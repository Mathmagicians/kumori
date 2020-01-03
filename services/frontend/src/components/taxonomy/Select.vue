<template>
<b-container fluid>
  <b-form-checkbox-group v-model="selected1" switches stacked :options="level1" />
  <hr v-if="selected1.length != 0">
  <b-form-checkbox-group v-if="selected1.length != 0" v-model="selected2" switches stacked :options="level2" />
  <hr v-if="selected2.length != 0">
  <b-form-checkbox-group v-if="selected2.length != 0" v-model="selected3" switches stacked :options="level3" />
  <hr v-if="selected3.length != 0">
  <b-form-checkbox-group v-if="selected3.length != 0" v-model="selected4" switches stacked :options="level4" />
</b-container>
</template>

<script>
import {
  mapGetters,
  mapActions,
  mapMutations
} from 'vuex'
export default {
  computed: {
    ...mapGetters('taxonomy', {
      options: 'selectOptions',
      level1: 'level1',
      level2: 'level2',
      level3: 'level3',
      level4: 'level4',
    }),
    ...mapGetters('usecase', {
      entry: 'current'
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
