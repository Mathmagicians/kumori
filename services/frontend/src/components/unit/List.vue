<template>
<b-container fluid>
  <b-row>
    <b-col>
      <b-row>
        <b-col>
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
  mapActions,
  mapMutations
} from 'vuex'
export default {
  name: "ComponentList",
  computed: {
    ...mapGetters('unit', {
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
    },
    query() {
      if (this.query.length > 2) {
        this.currentPage = 1
        this.search();
      }
      if (this.query.length < 2) {
        this.currentPage = 1
        this.search();
      }
    }
  },
  mounted() {
    this.search();
  },
  methods: {
    ...mapActions('unit', {
      current: 'current',
      search: 'search'
    })
  }
};
</script>

<style scoped></style>
