<template>
  <div>
    <b-pagination
      v-model="currentPage"
      :total-rows="totalRows"
      :per-page="perPage"
    ></b-pagination>
    <b-table striped small hover :items="data" :fields="fields">
      <template slot="actions" slot-scope="row">
        <b-button-group>
          <b-button size="sm" @click.stop="row.toggleDetails">
            <v-icon name="info" />
          </b-button>
          <b-button
            size="sm"
            @click="showedit(row.item)"
            v-if="isLoggedIn && isEditOn"
          >
            <v-icon name="pen" />
          </b-button>
          <b-button
            size="sm"
            @click="remove(row.item)"
            v-if="isLoggedIn && isEditOn"
          >
            Delete
          </b-button>






        </b-button-group>
      </template>
      <template slot="row-details" slot-scope="row">
        <div class="container">
          <div class="row">
            <div class="col-sm">
              {{ row.item.description }}
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
    <br /><br /><br /><br /><br /><br />
    <edit-usecase ref="editItem" />
  </div>
</template>

<script>
import Icon from "vue-awesome/components/Icon";
import "vue-awesome/icons/pen";
import "vue-awesome/icons/info";
import Usecases from "@/api/Usecases.js";
import EditUsecase from "@/components/usecase/Edit";

export default {
  name: "usecases",
  props: {
    perPage: {
      default: () => {
        return 10;
      }
    }
  },
  components: {
    "v-icon": Icon,
    "edit-usecase": EditUsecase
  },
  data() {
    return {
      fields: [
        {
          key: "name",
          label: "Name"
        },
        {
          key: "status",
          label: "Status"
        },
        {
          key: "actions",
          label: "Actions"
        }
      ],
      currentPage: 1,
      totalRows: 0,
      data: []
    };
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
    currentPage() {
      this.get();
    }
  },
  mounted() {
    this.get();
  },
  methods: {
    get() {
      let start = this.currentPage === 1 ? 0 : (this.currentPage - 1) * this.perPage;
      let stop = this.currentPage === 1 ? (this.currentPage * this.perPage) - 1 : (this.currentPage * this.perPage)
      Usecases.get(start, stop, [], ["id.desc"], [])
        .then(response => {
          this.data = response.data;
          this.totalRows = parseInt(response.total);
          this.isBusy = false;
        })
        .catch(error => {
          console.log(error);
        });
    },
    showedit(item) {
      this.$refs.editItem.show(item);
    },
    remove(item) {
      Usecases.deleteById(item.id).then(res => {
        console.log(`Deleted: ${item.id}`)
      }).catch(e => {
        console.log(e)
      })

    },
  }
};
</script>

<style scoped></style>
