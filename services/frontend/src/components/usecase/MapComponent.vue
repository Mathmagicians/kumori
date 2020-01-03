<template>
<b-modal v-model="showCreateUsecaseComponentMap" :title="title" @ok="save">
  <unit-select v-model="unit" />
  <status-select v-model="status" />
  <b-form-group id="fieldset-1" description="You may add a comment to this mapping" label="Description">
    <b-form-textarea v-model="description" placeholder="Enter something..." rows="3" max-rows="6"></b-form-textarea>
  </b-form-group>
</b-modal>
</template>

<script>
import {
  mapGetters,
  mapMutations,
  mapActions
} from 'vuex'
import UnitSelect from "@/components/unit/Select";
import StatusSelect from "@/components/status/Select";
import Unit from "@/api/Unit";
export default {
  components: {
    "unit-select": UnitSelect,
    "status-select": StatusSelect,
  },
  data() {
    return {
      unit: undefined,
      status: undefined,
      description: undefined
    };
  },
  computed: {
    showCreateUsecaseComponentMap: {
      set(showCreateUsecaseComponentMap) {
        this.$store.state.usecase.showCreateUsecaseComponentMap = showCreateUsecaseComponentMap
      },
      get() {
        return this.$store.state.usecase.showCreateUsecaseComponentMap
      }
    },
    title() {
      return `Map component to usecase: "${this.entry.name}"`
    },
    ...mapGetters('usecase', {
      entry: 'current',
      editable: 'editable'
    }),
  },
  methods: {
    save() {
      new Unit().addUsecase(this.unit, this.entry.id, this.status, this.description)
    }
  }
};
</script>

<style scoped></style>
