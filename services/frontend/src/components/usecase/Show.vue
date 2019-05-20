<template>
<b-card v-if="entry.id" no-body tag="article" border-variant="light" :header="entry.name">
  <b-card-body>
    <b-card-text>
      {{entry.description}}
    </b-card-text>
    <b-card-text>
      <hr />
      <h5>Status</h5>
      {{entry.status}}
    </b-card-text>
    <b-card-text v-if="entry.components.length">
      <hr />
      <h5>Components</h5>
      <ul>
        <li v-for="item in entry.components">{{item.name}}</li>
      </ul>
    </b-card-text>
  </b-card-body>
</b-card>
</template>

<script>
import {
  EventBus
} from "@/api/event-bus.js";
export default {
  name: "show",
  data() {
    return {
      entry: {
        id: null,
        name: "",
        description: "",
        status: "",
        components: []
      }
    }
  },
  mounted() {
    EventBus.$on("show-usecase", data => {
      this.entry = data;
    });
  }
};
</script>

<style scoped></style>
