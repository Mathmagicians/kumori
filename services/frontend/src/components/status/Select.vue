<template>
<b-form-group description="Please select a status" label="Select status">
  <b-form-select v-model="selected" :options="options" />
</b-form-group>
</template>

<script>
import {
  mapGetters,
  mapActions,
  mapMutations
} from 'vuex'
import Status from "@/api/Status";
export default {
  props: {
    value: {
      type: Number,
      default: undefined
    }
  },
  data() {
    return {
      options: []
    };
  },
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
  watch: {},
  mounted() {
    this.populate()
  },
  methods: {
    populate() {
      new Status().get(
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
