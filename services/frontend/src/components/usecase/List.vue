<template>
<b-container fluid>
  <b-row>
    <b-col>
      <b-row>
        <b-col>
          <b-button size="sm" title="Edit usecase" @click="add()" v-if="isLoggedIn && isEditOn">
            <v-icon name="pen" />
          </b-button>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <b-collapse id="collapse-1" class="mt-2">
            <b-card>
              <b-container fluid>
                <b-row>
                  <b-col>
                  </b-col>
                  <b-col>
                  </b-col>
                </b-row>
              </b-container>
            </b-card>
          </b-collapse>
          <b-table outlined striped small hover :busy="isBusy" :items="data" :fields="fields" @row-clicked="show">
            <div slot="table-busy" class="text-center text-danger my-2">
              <b-spinner class="align-middle"></b-spinner>
              <strong>Loading...</strong>
            </div>
          </b-table>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <b-pagination class="justify-content-center" v-model="currentPage" :total-rows="totalRows" :per-page="perPage"></b-pagination>
        </b-col>
      </b-row>
    </b-col>
  </b-row>
</b-container>
</template>

<script>
import {
  EventBus
} from "@/api/event-bus.js";

import Icon from "vue-awesome/components/Icon";
import "vue-awesome/icons/pen";
import "vue-awesome/icons/info";
import "vue-awesome/icons/trash";
import "vue-awesome/icons/boxes";
import "vue-awesome/icons/layer-group";

import Usecases from "@/api/Usecases.js";
export default {
  name: "usecase-list",
  components: {
    "v-icon": Icon,
  },
  props: {
    perPage: {
      default: () => {
        return 10;
      }
    }
  },
  data() {
    return {
      isBusy: true,
      fields: [{
          key: "name",
          label: "Name"
        },
        {
          key: "status",
          label: "Status"
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
  mounted() {
    EventBus.$on("update-usecase-list", () => {
      this.get();
    });
    this.get();
  },
  watch: {
    currentPage() {
      this.get();
    }
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
    add() {
      EventBus.$emit("show-add-usecase-dialog");
    },
    show(item) {
      let uid = item.id
      Usecases.get(
        0,
        1,
        [],
        [],
        [`id=eq.${uid}`]
      ).then(result => {
        EventBus.$emit("show-usecase", result.data[0]);
      })
    }
  }
};
</script>

<style scoped></style>
