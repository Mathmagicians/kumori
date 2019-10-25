<template>
<b-modal v-model="showCreateUsecaseComponentMap" :title="title" @ok="save">
  {{entry.id}} {{entry.name}}
</b-modal>
</template>

<script>
import {
  mapGetters,
  mapMutations,
  mapActions
} from 'vuex'
import Unit from "@/api/Unit";
export default {
  computed: {
    showCreateUsecaseComponentMap: {
      set(showCreateUsecaseComponentMap) {
        this.$store.state.usecase.showCreateUsecaseComponentMap = showCreateUsecaseComponentMap
      },
      get() {
        return this.$store.state.usecase.showCreateUsecaseComponentMap
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
      new Unit().addUsecase(2,1,1,'test')
    }
  }
};
</script>

<style scoped></style>
