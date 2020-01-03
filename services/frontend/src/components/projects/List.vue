<template>
<b-card :id="project.name" no-body>
  <span slot="header" :v-b-toggle="accordionId">
    <b-button variant="link">{{ project.name }}</b-button>
    <b-button to="/survey" variant="link">Project information</b-button>
    {{ project.status.value }}
    <weather :state="project.status.value" size="16" />
  </span>
  <div>{{ project.status }}</div>
</b-card>
</template>

<script>
import Weather from "@/components/projects/Weather";

export default {
  components: {
    weather: Weather
  },
  props: {
    project: {
      type: Object,
      required: true
    }
  },
  computed: {
    accordionId: function () {
      return "accordion-" + this.project.name;
    },
    statusIcon: function () {
      return this.iconNameFromValue(this.project.status.value);
    }
  },
  methods: {
    iconNameFromValue: function (val) {
      return val < 2 ? "sun" : "bolt";
    }
  }
};
</script>

<style scoped></style>
