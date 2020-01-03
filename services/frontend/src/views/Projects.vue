<template>
<split title="Projects">
  <template v-slot:left>
    <project />
  </template>
  Missing<template v-slot:right />
</split>
</template>

<script>
import Split from "@/components/Split";
import ProjectList from "@/components/projects/List";
import Project from "@/api/Project";

export default {
  name: "Projects",
  components: {
    "split": Split,
    project: ProjectList
  },
  data() {
    return {
      loading: false,
      projects: []
    };
  },
  mounted() {
    this.get()
  },
  methods: {
    get() {
      new Project().get().then(response => {
        this.project = response;
      }).catch(error => {
        console.log(error)
      })
    }
  }
};
</script>

<style scoped></style>
