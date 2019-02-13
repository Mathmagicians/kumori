<template>
<div>
  <b-table striped small hover :items="items" :fields="fields">
    <template slot="actions" slot-scope="row">
      <b-button-group>
        <b-button size="sm" variant="primary" v-if="isLoggedIn && isEditOn" @click="update(row.item.id,'test2','test3',1)">
          Update usecase one
        </b-button>
        <b-button size="sm" @click.stop="row.toggleDetails">
          <v-icon name="info" />
        </b-button>
        <edit-usecase :id="row.item.id" />
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

</div>
</template>

<script>
import Icon from 'vue-awesome/components/Icon'
import 'vue-awesome/icons/pen'
import 'vue-awesome/icons/info'
import Usecases from '../api/Usecases.js'
import EditUsecase from '../components/usecase/Edit'
export default {
  name: 'usecases',
  created() {},
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
  components: {
    'v-icon': Icon,
    'edit-usecase': EditUsecase
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
    update: function (a, b, c, d) {
      Usecases.update(a, b, c, d)
    },
    list: function () {
      let that = this
      let offset = this.currentPage * this.perPage
      let limit = (that.currentPage * that.perPage) + that.perPage
      Usecases.list(offset, limit, function (offset, limit, total, data) {
        that.items = data
        that.totalRows = parseInt(total)
      })
    }
  }
}
</script>

<style scoped>

</style>
