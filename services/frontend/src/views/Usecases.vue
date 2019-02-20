<template>
<div>
  <b-table striped small hover :items="items" :fields="fields">
    <template slot="actions" slot-scope="row">
      <b-button-group>
        <b-button size="sm" @click.stop="row.toggleDetails">
          <v-icon name="info" />
        </b-button>
        <b-button size="sm" @click="showedit(row.item)" v-if="isLoggedIn && isEditOn">
          <v-icon name="pen" />
        </b-button>
      </b-button-group>

    </template>
    <template slot="row-details" slot-scope="row">
      <div class="container">
        <div class="row">
          <div class="col-sm">
            {{row.item.description}}
          </div>
          <div class="col-sm">
            <h6>Associated components:</h6>
            <ul v-for="item in row.item.components" :key="item.id">
              <li>{{ item.name }}</li>
            </ul>
          </div>
        </div>
      </div>
    </template>
  </b-table>
  <b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" align="center" />
  <edit-usecase ref="editItem" />
</div>
</template>

<script>
import Icon from 'vue-awesome/components/Icon'
import 'vue-awesome/icons/pen'
import 'vue-awesome/icons/info'
import Usecases from '@/api/Usecases.js'
import EditUsecase from '@/components/usecase/Edit'

export default {
  name: 'usecases',
  created() {},
  components: {
    'v-icon': Icon,
    'edit-usecase': EditUsecase
  },
  data() {
    return {
      fields: [{
          key: 'name',
          label: 'Name'
        },
        {
          key: 'scope',
          label: 'Scope'
        },
        {
          key: 'status',
          label: 'Status'
        },
        {
          key: 'actions',
          label: 'Actions'
        }
      ],
      items: [],
      totalRows: 64,
      perPage: 10,
      currentPage: 0
    }
  },
  computed: {
    isLoggedIn() {
      return this.$store.getters.isLoggedIn;
    },
    isEditOn() {
      return this.$store.getters.isEditOn;
    }
  },
  watch: {
    currentPage: function () {
      this.list()
    }
  },
  methods: {
    list: function () {
      let that = this
      let offset = this.currentPage * this.perPage
      let limit = (that.currentPage * that.perPage) + that.perPage
      Usecases.list(offset, limit, function (offset, limit, total, data) {
        that.items = data
        that.totalRows = parseInt(total)
      })
    },
    showedit(item) {
      this.$refs.editItem.show(item)
    }
  }
}
</script>

<style scoped>

</style>
