<template>
<b-modal v-model="showCreateUsecaseTaxonomyMap" :title="title" @ok="save">
  <tax-select />
</b-modal>
</template>

<script>
import {
  mapGetters,
  mapMutations,
  mapActions
} from 'vuex'
import TaxSelect from "@/components/taxonomy/Select";
import Usecase from "@/api/Usecase"
export default {
  name: "map-taxonomy",
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
      return `Add usecase "${this.entry.name}"`
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
    save() {
      this.selected.forEach(entry => {
        new Usecase().setTaxonomy(this.entry.id, entry)
      })
    }
  }
};
</script>

<style scoped></style>
