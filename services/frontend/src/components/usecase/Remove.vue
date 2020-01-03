<template>
<b-modal ref="remove_usecase" v-model="showRemoveUsecase" :title="title" @ok="remove">
  <b-form-group description="Keep the name concise." label="Usecase name">
    <b-form-input v-model.trim="entry.name" readonly />
  </b-form-group>
  <b-form-group description="Keep the description comprehensive." label="Usecase description">
    <b-form-textarea v-model="entry.description" readonly placeholder="Enter something" :rows="3" :max-rows="6" />
  </b-form-group>
</b-modal>
</template>

<script>
import {
  mapGetters,
  mapMutations,
  mapActions
} from 'vuex'
import Usecase from "@/api/Usecase";
export default {
  name: "RemoveUsecase",
  computed: {
    showRemoveUsecase: {
      set(showRemoveUsecase) {
        this.$store.state.usecase.showRemoveUsecase = showRemoveUsecase
      },
      get() {
        return this.$store.state.usecase.showRemoveUsecase
      }
    },
    title() {
      return `Remove usecase: "${this.entry.name}"`
    },
    ...mapGetters('usecase', {
      entry: 'current',
      editable: 'editable'
    }),
  },
  methods: {
    ...mapActions('usecase', {
      remove: 'remove'
    }),
  }
};
</script>

<style scoped></style>
