<template>
<b-container fluid>
  <b-row>
    <b-col>
      <b-row>
        <b-col>
          <b-button v-b-toggle.collapse-1 variant="primary">Manage filters</b-button>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <b-collapse id="collapse-1" class="mt-2">
            <b-card>
              <b-container fluid>
                <b-row>
                  <b-col>
                    <b-form-checkbox-group v-model="status" :options="statuses" switches stacked></b-form-checkbox-group>
                  </b-col>
                  <b-col>
                    <tax-select />
                    <b-form-input v-model="query" placeholder="filter"></b-form-input>
                  </b-col>
                </b-row>
              </b-container>
            </b-card>
          </b-collapse>
          <b-table outlined striped hover small :busy="isBusy" :items="data" :fields="fields" @row-clicked="showDetails">
            <div slot="table-busy" class="text-center text-danger my-2">
              <b-spinner class="align-middle"></b-spinner>
              <strong>Loading...</strong>
            </div>
            <template slot="primary_usecase.name" slot-scope="data">
              <status-badge :label="data.value" />
            </template>
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
import Components from "@/api/Components.js";
import Statuses from "@/api/Statuses.js";
import StatusBadge from "@/components/status/Badge.vue";
import TaxSelect from "@/components/taxonomy/Select.vue";
export default {
  name: "component-list",
  components: {
    "status-badge": StatusBadge,
    "tax-select": TaxSelect
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
      currentPage: 1,
      totalRows: 0,
      query: '',
      data: [],
      fields: [{
          key: "name",
          label: "Name"
        },
        {
          key: "primary_usecase.name",
          label: "Primary Usecase Status"
        }
      ],
      statuses: [],
      status: [],
      taxonomy: []
    };
  },
  computed: {},
  mounted() {
    this.getComponents();
    this.getStatuses();
    EventBus.$on("taxonomy-filter-change", taxonomy => {
      this.taxonomy = taxonomy;
    });
  },
  watch: {
    currentPage() {
      this.getComponents();
    },
    status() {
      this.currentPage = 1
      this.getComponents();
    },
    taxonomy() {
      this.currentPage = 1
      this.getComponents();
    },
    query() {
      if (this.query.length > 2) {
        this.currentPage = 1
        this.getComponents();
      }
      if (this.query.length < 2) {
        this.currentPage = 1
        this.getComponents();
      }
    }
  },
  methods: {
    showDetails(item) {
      let uid = item.id
      Components.getC(
        0,
        1,
        [],
        [],
        [`uid=eq.${uid}`]
      ).then(result => {
        EventBus.$emit("component-info-changed", result.data[0]);
      })
    },
    toast(title, message, type) {
      this.$bvToast.toast(message, {
        variant: type,
        title: title,
        autoHideDelay: 5000,
        toaster: 'b-toaster-bottom-right'
      })
    },

    getComponents() {
      this.isBusy = true;
      let start = this.currentPage === 1 ? 0 : (this.currentPage - 1) * this.perPage;
      let stop = this.currentPage === 1 ? (this.currentPage * this.perPage) - 1 : (this.currentPage * this.perPage)
      Components.get(
          start,
          stop,
          ['id,name,primary_usecase'],
          [],
          [this.calcStatus(), this.calcTaxonomy(), this.calcFts()]
        )
        .then(response => {
          this.data = response.data;
          this.totalRows = parseInt(response.total);
          this.isBusy = false;
        })
        .catch(error => {
          this.toast('Error', error, 'danger')
        });
    },
    getStatuses() {
      Statuses.get(0, 10, ["id", "name"], [], [])
        .then(response => {
          this.statuses = response.data.map(entry => {
            return {
              text: entry.name,
              value: entry.id
            };
          });
        })
        .catch(error => {
          this.toast('Error', error, 'danger')
        });
    },
    calcStatus() {
      if (this.status.length > 0) {
        return `status=in.(${this.status})`;
      }
      return "";
    },
    calcTaxonomy() {
      if (this.taxonomy.length > 0) {
        return `tag=in.(${this.taxonomy})`;
      }
      return "";
    },
    calcFts() {
      if (this.query.length > 1) {
        return `search=ilike.*${encodeURI(this.query)}*`;
      }
      return "";
    }
  }
};
</script>

<style scoped></style>
