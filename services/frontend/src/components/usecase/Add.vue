<template>
<b-modal v-model="showAddUsecase" ref="add_usecase" :title="title" @ok="save" @cancel="cancel">
  <b-form-group description="Keep the name concise." label="Usecase name">
    <b-form-input v-model.trim="usecase.name"></b-form-input>
  </b-form-group>
  <b-form-group description="Keep the description comprehensive." label="Usecase description">
    <b-form-textarea v-model="usecase.description" placeholder="Enter something" :rows="3" :max-rows="6">
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
  name: "add",
  data() {
    return {
      usecase: {
        id: null,
        name: "",
        description: ""
      },
      options: [],
      selected: null
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
    title() {
      return `Add usecase "${this.usecase.name}"`
    }
  },
  methods: {
    ...mapMutations('usecase', {
      toggleAddUsecase: 'toggleAddUsecase'
    }),
    ...mapActions('usecase', {
      current: 'current',
      search: 'search'
    }),
    reset() {
      this.usecase = {
        id: null,
        name: "",
        description: ""
      }
    },
    save() {
      new Usecase().insert(
        this.usecase.name,
        this.usecase.description
      ).then(() => {
        this.reset()
        this.search()
      })
    },
    cancel() {
      this.search()
    }
  }
};
</script>

<style scoped></style>
