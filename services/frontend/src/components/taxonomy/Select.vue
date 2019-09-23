<template>
<b-container fluid>
  <b-form-checkbox-group switches stacked v-model="selected" :options="options">
  </b-form-checkbox-group>
</b-container>
</template>

<script>
import {
  mapGetters,
  mapActions,
  mapMutations
} from 'vuex'
export default {
  name: "tax-select",
  computed: {
    ...mapGetters('taxonomy', {
      options: 'selectOptions',
    }),
    selected: {
      set(selected) {
        this.setSelected(selected)
      },
      get() {
        return this.$store.state.taxonomy.selected
      }
    }
  },
  mounted() {
    this.list();
  },
  methods: {
    ...mapActions('taxonomy', {
      list: 'list'
    }),
    ...mapMutations('taxonomy', {
      setSelected: 'setSelected'
    })
  }
};
</script>

<style scoped></style>
