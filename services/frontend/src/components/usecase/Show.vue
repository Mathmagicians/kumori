<template>
<b-card v-if="entry.id" no-body tag="article" border-variant="light">
  <div slot="header">
    <b-dropdown v-if="authenticated && !readonly" class="float-right" right size="sm">
      <template slot="button-content">
        <v-icon name="bars" />
      </template>
      <b-dropdown-item title="Edit usecase" @click="toggleEditUsecase">
        <v-icon name="pen" /> Edit
      </b-dropdown-item>
      <b-dropdown-item title="Map component" @click="toggleCreateUsecaseComponentMap">
        <v-icon name="boxes" /> Map components
      </b-dropdown-item>
      <b-dropdown-item title="Map taxononomy" @click="toggleCreateUsecaseTaxonomyMap">
        <v-icon name="layer-group" /> Map taxononomy
      </b-dropdown-item>
      <b-dropdown-divider />
      <b-dropdown-item title="Remove usecase" @click="toggleRemoveUsecase">
        <v-icon name="trash" /> Remove
      </b-dropdown-item>
    </b-dropdown>
    <h5>{{ entry.name }}</h5>
  </div>
  <b-card-body>
    <b-card-text>
      {{ entry.description }}
    </b-card-text>
    <ul v-if="entry.taxonomy.length>0">
      <li v-for="tax in entry.taxonomy" :key="tax.name">
        {{ tax.name }}
      </li>
    </ul>
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
import "vue-awesome/icons/boxes";
import "vue-awesome/icons/bars";
import "vue-awesome/icons/layer-group";
export default {
  name: "Show",
  components: {
    "v-icon": Icon,
  },
  computed: {
    ...mapGetters([
      'authenticated',
      'readonly'
    ]),
    ...mapGetters('usecase', {
      entry: 'current',
      editable: 'editable'
    }),
  },
  methods: {
    ...mapMutations('usecase', {
      toggleEditUsecase: 'toggleEditUsecase',
      toggleRemoveUsecase: 'toggleRemoveUsecase',
      toggleCreateUsecaseComponentMap: 'toggleCreateUsecaseComponentMap',
      toggleCreateUsecaseTaxonomyMap: 'toggleCreateUsecaseTaxonomyMap'
    })
  }
};
</script>

<style scoped></style>
