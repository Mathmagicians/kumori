<template>
<split title="Taxonomy">
  <template v-slot:left>
    <tax/></template>
  <template v-slot:right>
    <h1>Selected</h1>
    {{selected}}
</template>
</split>
</template>

<script>
import {
  mapGetters,
  mapActions,
  mapMutations
} from 'vuex'
import Split from "@/components/Split";
import TaxonomySelect from "@/components/taxonomy/Select";

export default {
  name: "about",
  data() {
    return {
    };
  },
  computed: {
    ...mapGetters('taxonomy', {
      selected:  'selected'
    }),
  },
  components: {
    "split": Split,
    "tax": TaxonomySelect,

  },
  methods: {}
};
</script>

<style scoped>
</style>
