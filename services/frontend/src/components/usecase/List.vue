<template>
<b-container fluid>
  <b-row>
    <b-col>
      <b-row>
        <b-col>
          <b-button v-if="authenticated && !readonly" size="sm" title="Edit usecase" @click="toggleAddUsecase">
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
                  <b-col />
                  <b-col />
                </b-row>
              </b-container>
            </b-card>
          </b-collapse>
          <b-table outlined striped hover small :busy="list.busy" :items="list.data" :fields="list.fields" @row-clicked="current">
            <div slot="table-busy" class="text-center text-danger my-2">
              <b-spinner class="align-middle" />
              <strong>Loading...</strong>
            </div>
            <template slot="HEAD_name">
              <b-form-input v-model="query" size="sm" placeholder="Filter" />
            </template>
          </b-table>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <b-pagination v-model="currentPage" class="justify-content-center" :total-rows="list.totalRows" :per-page="list.perPage" />
        </b-col>
      </b-row>
    </b-col>
  </b-row>
</b-container>
</template>

<script>
import {
  mapGetters,
  mapMutations,
  mapActions
} from 'vuex'
import Icon from "vue-awesome/components/Icon";
import "vue-awesome/icons/pen";
import "vue-awesome/icons/info";
import "vue-awesome/icons/trash";
import "vue-awesome/icons/boxes";
import "vue-awesome/icons/layer-group";

import Usecase from "@/api/Usecase";
export default {
  components: {
    "v-icon": Icon,
  },
  computed: {
    ...mapGetters([
      'authenticated',
      'readonly'
    ]),
    ...mapGetters('usecase', {
      list: 'list'
    }),
    query: {
      set(query) {
        this.$store.state.unit.list.query = query
      },
      get() {
        return this.$store.state.unit.list.query
      }
    },
    currentPage: {
      set(selected) {
        this.$store.state.unit.list.currentPage = selected
      },
      get() {
        return this.$store.state.unit.list.currentPage
      }
    }
  },
  watch: {
    currentPage() {
      this.search();
    }
  },
  mounted() {
    this.search()
  },
  methods: {
    ...mapActions('usecase', {
      current: 'current',
      search: 'search'
    }),
    ...mapMutations('usecase', {
      toggleAddUsecase: 'toggleAddUsecase',
    })
  }
};
</script>

<style scoped></style>
