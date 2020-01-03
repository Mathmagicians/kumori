<template>
<b-modal v-model="showRemoveUsecase" ref="remove_usecase" :title="title" @ok="remove">
  <b-form-group description="Keep the name concise." label="Usecase name">
    <b-form-input readonly v-model.trim="entry.name"></b-form-input>
  </b-form-group>
  <b-form-group description="Keep the description comprehensive." label="Usecase description">
    <b-form-textarea readonly v-model="entry.description" placeholder="Enter something" :rows="3" :max-rows="6">
    </b-form-textarea>
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
  name: "remove-usecase",
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
