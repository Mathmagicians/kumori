<template>
<b-card v-if="entry.uid" no-body tag="article" border-variant="light" :header="entry.name">
  <b-card-body>
    <b-card-text>
      {{entry.description}}
    </b-card-text>
    <b-card-text v-if="entry.usecases.length">
      <hr />
      <h5>Usecases</h5>
      <ul>
        <li v-for="item in entry.usecases">
          <h6>{{item.name}}</h6>
          <p>{{item.name}}</p>
          <p>{{item.status}}</p>
        </li>
      </ul>
    </b-card-text>
    <b-card-text v-if="entry.links.length">
      <hr />
      <h5>Links</h5>
      <ul>
        <li v-for="item in entry.links">{{item.ref}}</li>
      </ul>
    </b-card-text>
    <b-card-text v-if="entry.comments.length">
      <hr />
      <h5>Comments</h5>
      <ul>
        <li v-for="item in entry.comments">{{item}}
        </li>
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
        uid: null,
        name: "",
        status: "",
        description: "",
        comments: [],
        tags: [],
        licenses: [],
        links: [],
        usecases: []
      }
    }
  },
  mounted() {
    EventBus.$on("component-info-changed", data => {
      this.entry = data;
    });
  }
};
</script>

<style scoped></style>
