<template>
<b-modal ref="add_usecase" :title="title" @ok="save" @cancel="cancel">
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
  EventBus
} from "@/api/event-bus.js";
import Usecases from "@/api/Usecases.js";
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
  mounted() {
    EventBus.$on("show-add-usecase-dialog", () => {
      this.$refs.add_usecase.show();
    });
  },
  computed: {
    title() {
      return `Add usecase "${this.usecase.name}"`
    }
  },
  methods: {
    reset() {
      this.usecase = {
        id: null,
        name: "",
        description: ""
      }
    },
    save() {
      Usecases.insert(
        this.usecase.name,
        this.usecase.description
      ).then(() => {
        this.reset()
        EventBus.$emit("update-usecase-list");
      })
    },
    cancel() {
      EventBus.$emit("update-usecase-list");
    }
  }
};
</script>

<style scoped></style>
