<template>
<b-modal ref="remove_usecase" :title="title" @ok="remove" @cancel="cancel">
  <b-form-group description="Keep the name concise." label="Usecase name">
    <b-form-input readonly v-model.trim="usecase.name"></b-form-input>
  </b-form-group>
  <b-form-group description="Keep the description comprehensive." label="Usecase description">
    <b-form-textarea readonly v-model="usecase.description" placeholder="Enter something" :rows="3" :max-rows="6">
    </b-form-textarea>
  </b-form-group>
</b-modal>
</template>

<script>
import {
  EventBus
} from "@/api/event-bus.js";
import Usecases from "@/api/Usecases.js";
export default {
  name: "remove-usecase",
  data() {
    return {
      usecase: {
        id: undefined,
        name: undefined,
        description: undefined
      }
    }
  },
  mounted() {
    EventBus.$on("show-remove-usecase-dialog", usecase => {
      this.usecase = usecase
      this.$refs.remove_usecase.show();
    });
  },
  computed: {
    title() {
      return `Remove usecase "${this.usecase.name}"`
    }
  },
  methods: {
    remove() {
      Usecases.deleteById(this.usecase.id).then(res => {
        EventBus.$emit("update-usecase-list");
      }).catch(e => {
        console.log(e)
      })
    },
    cancel() {
      EventBus.$emit("update-usecase-list");
    }
  }
};
</script>

<style scoped></style>
