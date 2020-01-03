<template>
<div>
  <b-button-group size="sm">
    <b-button disabled variant="secondary">Phase</b-button>
    <b-button :variant="phaseColor">{{ phase }}</b-button>
    <b-button disabled variant="secondary">Status</b-button>
    <b-button :variant="statusColor">{{ status }}</b-button>
  </b-button-group>

</div>

</div>
</template>

<script>
import {
  mapGetters,
  mapActions,
  mapMutations
} from 'vuex'
export default {
  props: {
    status: {
      type: String,
      default: () => {
        return "To be decided";
      }
    },
    phase: {
      type: String,
      default: () => {
        return "Maybe"
      }
    }
  },
  computed: {
    ...mapGetters('status', {
      statusList: 'list',
    }),
    ...mapGetters('phase', {
      phaseList: 'list',
    }),
    statusColor() {
      let s = this.statusColorMap.filter(entry => {
        return entry.name === this.status;
      })[0];
      if (s !== undefined) {
        return s.variant;
      }
      return "Missing";
    },
    phaseColor() {
      let s = this.phaseColorMap.filter(entry => {
        return entry.name === this.phase;
      })[0];
      if (s !== undefined) {
        return s.variant;
      }
      return "Missing";
    },
    phaseColorMap() {
      return this.phaseList.map(entry => {
        let t = {};
        switch (entry.name) {
          case "Maybe":
            t = {
              name: entry.name,
              variant: "info"
            };
            break;
          case "Buy":
            t = {
              name: entry.name,
              variant: "success"
            };
            break;
          case "Hold":
            t = {
              name: entry.name,
              variant: "success"
            };
            break;
          case "Sell":
            t = {
              name: entry.name,
              variant: "danger"
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
    },
    statusColorMap() {
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
              variant: "info"
            };
            break;
          case "Undecided":
            t = {
              name: entry.name,
              variant: "info"
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
    this.getPhases()
  },
  methods: {
    ...mapActions('status', {
      getStatuses: 'list'
    }),
    ...mapActions('phase', {
      getPhases: 'list'
    }),
  }
};
</script>

<style scoped></style>
