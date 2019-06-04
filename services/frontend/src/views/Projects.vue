<template>
  <b-container fluid>
    <h1>Projects</h1>
  </b-container>
</template>

<script>
import Project from "../components/projects/Project.vue";
import Projects from "../api/Projects.js";

export default {
  name: "projects",
  components: {
    project: Project
  },
  data() {
    return {
      loading: false,
      projects: Projects.list()
    };
  }
};
</script>

<style scoped></style>
