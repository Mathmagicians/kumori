<template>
<b-modal ref="edit_component" :title="title" @ok="save" @cancel="cancel">
  <b-form-group description="Keep the name concise." label="Component name">
    <b-form-input v-model.trim="entry.name"></b-form-input>
  </b-form-group>
  <b-form-group description="Keep the description comprehensive." label="Component description">
    <b-form-textarea v-model="entry.description" placeholder="Enter something" :rows="3" :max-rows="6">
    </b-form-textarea>
  </b-form-group>
</b-modal>
</template>

<script>
import {
  EventBus
} from "@/api/event-bus.js";
import Components from "@/api/Components.js";
export default {
  name: "edit",
  data() {
    return {
      entry: {
        uid: null,
        name: "",
        description: ""
      },
      options: [],
      selected: null
    };
  },
  mounted() {
    EventBus.$on("show-edit-component-dialog", component => {
      this.entry = component
      this.$refs.edit_component.show();
    });
  },
  computed: {
    title() {
      return `Edit component "${this.entry.name}"`
    }
  },
  methods: {
    save() {
      Components.update(
        this.entry.uid,
        this.entry.name,
        this.entry.description
      ).then(() => {
        EventBus.$emit("update-component-list");
      })
    },
    cancel() {
      EventBus.$emit("update-component-list");
    }
  }
};
</script>

<style scoped></style>
