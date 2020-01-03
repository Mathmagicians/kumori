<template>
<b-card v-if="entry.id" no-body tag="article" border-variant="light">
  <div slot="header">
    <b-dropdown v-if="authenticated && !readonly" class="float-right" right size="sm">
      <template slot="button-content">
        <v-icon name="bars" />
      </template>
      <b-dropdown-item title="Edit usecase" @click="edit(entry)">
        <v-icon name="pen" /> Edit
      </b-dropdown-item>
      <b-dropdown-divider />
      <b-dropdown-item title="Remove usecase" @click="remove(entry)">
        <v-icon name="trash" /> Remove
      </b-dropdown-item>
    </b-dropdown>
    <b-button v-if="editable" class="float-right" variant="primary" size="sm" @click="update">
      Save
    </b-button>
    <b-form-group :description="nameDescription" :label="nameLabel">
      <b-form-input v-model.trim="entry.name" :plaintext="!editable" />
    </b-form-group>
  </div>
  <b-card-body>
    <b-card-text>
      <b-form-group :description="descDescription" :label="descLabel">
        <b-form-textarea v-model="entry.description" :plaintext="!editable" placeholder="Enter something" :rows="3" :max-rows="6" />
      </b-form-group>
    </b-card-text>

    <b-card-text v-if="entry.usecases.length">
      <hr>
      <h5>Usecases</h5>
      <ul>
        <li v-for="item in entry.usecases" :key="item.name">
          <h6>{{ item.name }}</h6>
          <p>{{ item.description }}</p>
          <status-badge :status="item.status" :phase="item.phase"/>
        </li>
      </ul>
    </b-card-text>
  </b-card-body>
</b-card>
</template>

<script>
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
import Badge from "@/components/status/Badge";
export default {
  components: {
    "v-icon": Icon,
    "status-badge": Badge,
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
      } else {
        return ''
      }
    },
    nameLabel() {
      if (this.editable) {
        return `Name`
      } else {
        return ''
      }
    },
    descDescription() {
      if (this.editable) {
        return `Keep the description comprehensive.`
      } else {
        return ''
      }
    },
    descLabel() {
      if (this.editable) {
        return `Description`
      } else {
        return ''
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
