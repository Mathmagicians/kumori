<template>
<div>
  <b-pagination v-model="currentPage" :total-rows="totalRows" :per-page="perPage"></b-pagination>
  <b-table outlined striped hover small :busy="isBusy" :items="data" :fields="fields">
    <div slot="table-busy" class="text-center text-danger my-2">
      <b-spinner class="align-middle"></b-spinner>
      <strong>Loading...</strong>
    </div>
  </b-table>
</div>
</template>

<script>
import Components from '@/api/Components.js'
export default {
  name: 'list',
  components: {},
  props: {
    perPage: {
      default: () => { return 10 }
    }
  },
  data() {
    return {
      isBusy: true,
      currentPage: 1,
      totalRows: 0,

      data: [],
      fields: [{
          key: 'name',
          label: 'Name'
        },
        {
          key: 'primary_usecase.name',
          label: 'Status'
        }
      ]
    }
  },
  computed: {},
  mounted() {
    this.get()
  },
  watch: {
    currentPage: function () {
      this.get()
    }
  },
  methods: {
    get() {
      this.isBusy = true
      let start = this.currentPage === 1 ? 0 : (this.currentPage - 1) * this.perPage
      let stop = this.currentPage * this.perPage
      Components.get(start, stop, [], [], ['name=ilike.*Apache*']).then(response => {
        this.data = response.data
        this.totalRows = parseInt(response.total)
        this.isBusy = false
      }).catch(error => {
        console.log(error);
      })
    }
  }
}
</script>

<style scoped>
</style>
