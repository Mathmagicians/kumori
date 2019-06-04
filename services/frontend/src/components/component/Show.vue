<template>
<b-card v-if="entry.uid"  no-body tag="article" border-variant="light">
  <div slot="header">
    <b-dropdown class="float-right" right size="sm" v-if="authenticated && !readonly">
      <template slot="button-content">
        <v-icon name="bars" /></template>
      <b-dropdown-item title="Edit usecase" @click="edit(entry)">
        <v-icon name="pen" /> Edit</b-dropdown-item>
      <b-dropdown-divider></b-dropdown-divider>
      <b-dropdown-item title="Remove usecase" @click="remove(entry)">
        <v-icon name="trash" /> Remove</b-dropdown-item>
    </b-dropdown>
    <h5>{{entry.name}}</h5>
  </div>
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
import {
  mapGetters
} from 'vuex'
import Icon from "vue-awesome/components/Icon";
import "vue-awesome/icons/pen";
import "vue-awesome/icons/info";
import "vue-awesome/icons/trash";
import "vue-awesome/icons/bars";
export default {
  name: "show",
  components: {
    "v-icon": Icon,
  },
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
  computed: {
    ...mapGetters([
      'authenticated',
      'readonly'
    ])
  },
  mounted() {
    EventBus.$on("component-info-changed", data => {
      this.entry = data;
    });
  },
  methods: {
    remove(item) {
      EventBus.$emit("show-remove-component-dialog", item);
    },
    edit(item) {
      EventBus.$emit("show-edit-component-dialog", item);
    }
  }
};
</script>

<style scoped></style>
