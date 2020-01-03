<template>
<div>
  <b-badge :variant="color">
    {{ label }}
  </b-badge>
</div>
</template>

<script>
import {
  mapGetters,
  mapActions,
  mapMutations
} from 'vuex'
export default {
  name: "Badge",
  props: {
    label: {
      type: String,
      default: () => {
        return "To be decided";
      }
    }
  },
  computed: {
    ...mapGetters('status', {
      statusList: 'list',
    }),
    color() {
      let s = this.colorMap.filter(entry => {
        return entry.name === this.label;
      })[0];
      if (s !== undefined) {
        return s.variant;
      }
      return "Missing";
    },
    colorMap() {
      return this.statusList.map(entry => {
        let t = {};
        switch (entry.name) {
          case "POC":
            t = {
              name: entry.name,
              variant: "primary"
            };
            break;
          case "Testing":
            t = {
              name: entry.name,
              variant: "primary"
            };
            break;
          case "Experiment":
            t = {
              name: entry.name,
              variant: "primary"
            };
            break;
          case "Deprecated":
            t = {
              name: entry.name,
              variant: "danger"
            };
            break;
          case "Do not use":
            t = {
              name: entry.name,
              variant: "danger"
            };
            break;
          case "To be decided":
            t = {
              name: entry.name,
              variant: "secondary"
            };
            break;
          case "Undecided":
            t = {
              name: entry.name,
              variant: "secondary"
            };
            break;
          case "Limited":
            t = {
              name: entry.name,
              variant: "success"
            };
            break;
          case "Default":
            t = {
              name: entry.name,
              variant: "success"
            };
            break;
        }
        return t;
      });
    }
  },
  mounted() {
    this.getStatuses()
  },
  methods: {
    ...mapActions('status', {
      getStatuses: 'list'
    })
  }
};
</script>

<style scoped></style>
