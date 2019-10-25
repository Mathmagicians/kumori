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
  },
  methods: {
    save() {
      console.log('Not implemented')
    }
  }
};
</script>

<style scoped></style>
