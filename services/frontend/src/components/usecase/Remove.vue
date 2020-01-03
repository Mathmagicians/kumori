<template>
<b-modal ref="remove_usecase" v-model="showRemoveUsecase" :title="title" @ok="remove">
  <b-form-group description="Keep the name concise." label="Usecase name">
    <b-form-input v-model.trim="entry.name" readonly />
  </b-form-group>
  <b-form-group description="Keep the description comprehensive." label="Usecase description">
    <b-form-textarea v-model="entry.description" readonly placeholder="Enter something" :rows="3" :max-rows="6" />
  </b-form-group>
  <template v-slot:modal-footer="{ ok, cancel }">
    <b-button variant="danger" @click="ok()">
      Remove
    </b-button>
    <b-button variant="secondary" @click="cancel()">
      Cancel
    </b-button>
  </template>
</b-modal>
</template>

<script>
import {
  mapGetters,
  mapMutations,
  mapActions
} from 'vuex'
export default {
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
      entry: 'current'
    })
  },
  methods: {
    ...mapActions('usecase', {
      remove: 'remove'
    })
  }
};
</script>

<style scoped></style>
