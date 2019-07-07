<template>
<split title="Projects">
  <template v-slot:left>
    Missing</template>
  Missing<template v-slot:right>
</template>
</split>
</template>

<script>
import Split from "@/components/Split";
import ProjectList from "@/components/projects/List";
import Badge from "@/components/status/Badge";
import Project from "@/api/Project";

export default {
  name: "projects",
  components: {
    "split": Split,   "badge": Badge,
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
