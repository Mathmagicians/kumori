<template>
<b-container fluid>
  <b-form-checkbox-group switches stacked v-model="selected1" :options="level1">
  </b-form-checkbox-group>
  <hr v-if="selected1.length != 0" />
  <b-form-checkbox-group v-if="selected1.length != 0" switches stacked v-model="selected2" :options="level2">
  </b-form-checkbox-group>
  <hr v-if="selected2.length != 0" />
  <b-form-checkbox-group v-if="selected2.length != 0" switches stacked v-model="selected3" :options="level3">
  </b-form-checkbox-group>
  <hr v-if="selected3.length != 0" />
  <b-form-checkbox-group v-if="selected3.length != 0" switches stacked v-model="selected4" :options="level4">
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
      level1: 'level1',
      level2: 'level2',
      level3: 'level3',
      level4: 'level4',
      selected: 'selected',
    }),
    selected1: {
      set(selected1) {
        this.setSelected1(selected1)
      },
      get() {
        return this.$store.state.taxonomy.selected1
      }
    },
    selected2: {
      set(selected2) {
        this.setSelected2(selected2)
      },
      get() {
        return this.$store.state.taxonomy.selected2
      }
    },
    selected3: {
      set(selected3) {
        this.setSelected3(selected3)
      },
      get() {
        return this.$store.state.taxonomy.selected3
      }
    },
    selected4: {
      set(selected4) {
        this.setSelected4(selected4)
      },
      get() {
        return this.$store.state.taxonomy.selected4
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
      setSelected1: 'setSelected1',
      setSelected2: 'setSelected2',
      setSelected3: 'setSelected3',
      setSelected4: 'setSelected4'
    })
  }
};
</script>

<style scoped></style>
