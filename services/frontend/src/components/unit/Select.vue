<template>
<b-form-group description="Please select a component" label="Select component">
  <b-form-select v-model="selected" :options="options"></b-form-select>
</b-form-group>
</template>

<script>
import {
  mapGetters,
  mapActions,
  mapMutations
} from 'vuex'
import Unit from "@/api/Unit";
export default {
  name: "component-select",
  data() {
    return {
      options: []
    };
  },
  props: ['value'],
  computed: {
    selected: {
      get() {
        return this.value;
      },
      set(val) {
        this.$emit('input', val);
      }
    }
  },
  mounted() {
    this.populate()
  },
  watch: {},
  methods: {
    populate() {
      new Unit().get(
        0,
        2000,
        ['id,name'],
        [],
        []
      ).then(response => {
        this.options = response.data.map(entry => {
          return {
              value: entry.id,
              text: entry.name
          }
        })
      })
    }
  }
};
</script>

<style scoped></style>
