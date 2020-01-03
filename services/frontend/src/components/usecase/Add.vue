<template>
<b-modal ref="add_usecase" v-model="showAddUsecase" :title="title" @ok="save">
  <b-form-group description="Keep the name concise." label="Usecase name">
    <b-form-input v-model.trim="usecase.name" />
  </b-form-group>
  <b-form-group description="Keep the description comprehensive." label="Usecase description">
    <b-form-textarea v-model="usecase.description" placeholder="Enter something" :rows="3" :max-rows="6" />
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
import Usecase from "@/api/Usecase";
export default {
  data() {
    return {
      usecase: {
        name: undefined,
        description: undefined
      }
    };
  },
  computed: {
    showAddUsecase: {
      set(showAddUsecase) {
        this.$store.state.usecase.showAddUsecase = showAddUsecase
      },
      get() {
        return this.$store.state.usecase.showAddUsecase
      }
    },
    title () {
      return `Add usecase "${this.usecase.name}"`
    }
  },
  methods: {
    ...mapActions('usecase', {
      insert: 'insert'
    }),
    save() {
      this.insert(this.usecase).then(() => {
        this.usecase.name = "";
        this.usecase.description = "";
      })
    }
  }
};
</script>

<style scoped></style>
