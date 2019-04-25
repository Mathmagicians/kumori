<template>
<b-container fluid>
  <b-form-checkbox-group switches stacked v-model="selected.root" :options="taxonomy.root">
  </b-form-checkbox-group>
</b-container>
</template>

<script>
import {
  EventBus
} from '@/api/event-bus.js';
import Taxonomy from '@/api/Taxonomy.js'
export default {
  name: 'tax-select',
  components: {},
  data() {
    return {
      selected: {
        root: []
      },
      taxonomy: {
        root: {}
      }
    }
  },
  computed: {
    taxonomies() {
      return this.selected.root
    }
  },
  watch: {
    taxonomies() {
      this.taxonomyFilterChange()
    }
  },
  mounted() {
    this.getBurst()
  },
  methods: {
    taxonomyFilterChange() {
      EventBus.$emit('taxonomy-filter-change', this.taxonomies);
    },
    getBurst() {
      Taxonomy.sunburst().then(response => {
        this.taxonomy.root = response.filter(f => {
          return f.level == 1
        }).map(g => {
          return {
            text: g.name,
            value: g.id
          }
        })
      }).catch(error => {
        console.log(error);
      })
    }
  }
}
</script>

<style scoped>
</style>
