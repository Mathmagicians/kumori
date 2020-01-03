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
export default {
  name: "Projects",
  components: {
    "split": Split,
    project: ProjectList
  }
};
</script>

<style scoped></style>
