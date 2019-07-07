<template>
<b-modal ref="edit_usecase" :title="title" @ok="save" @cancel="cancel">
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
import Usecase from "@/api/Usecase";
export default {
  name: "edit",
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
    EventBus.$on("show-edit-usecase-dialog", usecase => {
      this.usecase = usecase
      this.$refs.edit_usecase.show();
    });
  },
  computed: {
    title() {
      return `Edit usecase "${this.usecase.name}"`
    }
  },
  methods: {
    save() {
      new Usecase().update(
        this.usecase.id,
        this.usecase.name,
        this.usecase.description
      ).then(() => {
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
