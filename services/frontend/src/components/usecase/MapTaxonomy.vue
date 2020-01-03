<template>
<b-modal v-model="showCreateUsecaseTaxonomyMap" :title="title" @ok="save">
  <tax-select />
</b-modal>
</template>

<script>
import {
  mapGetters,
  mapMutations,
  mapActions,
  mapState
} from 'vuex'
import TaxSelect from "@/components/taxonomy/Select";
import Usecase from "@/api/Usecase"
export default {
  name: "MapTaxonomy",
  components: {
    "tax-select": TaxSelect,
  },
  computed: {
    showCreateUsecaseTaxonomyMap: {
      set(showCreateUsecaseTaxonomyMap) {
        this.$store.state.usecase.showCreateUsecaseTaxonomyMap = showCreateUsecaseTaxonomyMap
      },
      get() {
        return this.$store.state.usecase.showCreateUsecaseTaxonomyMap
      }
    },
    title() {
      return `Map taxonomy for usecase: "${this.entry.name}"`
    },
    ...mapGetters('usecase', {
      entry: 'current',
      editable: 'editable'
    }),
    ...mapGetters('taxonomy', {
      selected: 'selected'
    }),
  },
  methods: {
    ...mapMutations('taxonomy', {
      reset: 'reset'
    }),
    ...mapActions('usecase', {
      current: 'current'
    }),
    save() {
      new Usecase().clearTaxonomy(this.entry.id).then(() => {
        let entries = []
        this.selected.forEach(entry => {
          entries.push(new Usecase().setTaxonomy(this.entry.id, entry))
        })
        Promise.all(entries).then(() => {
          this.current(this.entry)
          this.reset()
        })
      })
    }
  }
}
</script>

<style scoped></style>
