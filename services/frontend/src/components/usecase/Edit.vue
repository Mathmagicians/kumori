<template>
<b-modal ref="edit_usecase" v-model="showEditUsecase" :title="title" @ok="update" @cancel="search">
  <b-form-group description="Keep the name concise." label="Usecase name">
    <b-form-input v-model.trim="entry.name" />
  </b-form-group>
  <b-form-group description="Keep the description comprehensive." label="Usecase description">
    <b-form-textarea v-model="entry.description" placeholder="Enter something" :rows="3" :max-rows="6" />
  </b-form-group>
  <template v-slot:modal-footer="{ ok, cancel }">
    <b-button variant="primary" @click="ok()">
      Save
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
    showEditUsecase: {
      set(showEditUsecase) {
        this.$store.state.usecase.showEditUsecase = showEditUsecase
      },
      get() {
        return this.$store.state.usecase.showEditUsecase
      }
    },
    title() {
      return `Edit usecase "${this.entry.name}"`
    },
    ...mapGetters('usecase', {
      entry: 'current',
    }),
  },
  methods: {
    ...mapActions('usecase', {
      update: 'update',
      search: 'search',
    })
  }
};
</script>

<style scoped></style>
