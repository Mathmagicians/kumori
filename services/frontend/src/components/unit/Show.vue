<template>
<b-card v-if="entry.uid" no-body tag="article" border-variant="light">
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
    <b-button class="float-right" variant="primary" size="sm" v-if="editable" @click="update">Save</b-button>
    <b-form-group :description="nameDescription" :label="nameLabel">
      <b-form-input :plaintext="!editable" v-model.trim="entry.name"></b-form-input>
    </b-form-group>
  </div>
  <b-card-body>
    <b-card-text>
      <b-form-group :description="descDescription" :label="descLabel">
        <b-form-textarea :plaintext="!editable" v-model="entry.description" placeholder="Enter something" :rows="3" :max-rows="6">
        </b-form-textarea>
      </b-form-group>
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
  mapGetters,
  mapMutations,
  mapActions
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
  computed: {
    ...mapGetters([
      'authenticated',
      'readonly'
    ]),
    ...mapGetters('unit', {
      entry: 'current',
      editable: 'editable'
    }),
    nameDescription() {
      if (this.editable) {
        return `Keep the name concise.`
      }
    },
    nameLabel() {
      if (this.editable) {
        return `Name`
      }
    },
    descDescription() {
      if (this.editable) {
        return `Keep the description comprehensive.`
      }
    },
    descLabel() {
      if (this.editable) {
        return `Description`
      }
    }
  },
  methods: {
    ...mapMutations('unit', {
      setEditable: 'setEditable'
    }),
    ...mapActions('unit', {
      update: 'update'
    }),
    remove(item) {
      this.setEditable(true)
    },
    edit(item) {
      this.setEditable(true)
    }
  }
};
</script>

<style scoped></style>
