<template>
  <b-container fluid>
  <b-row>
    <b-col><c-list /></b-col>
    <b-col><c-show /></b-col>
  </b-row>
</b-container>
</template>

<script>
import ComponentList from "@/components/component/List";
import ComponentShow from "@/components/component/Show";
export default {
  name: "list",
  components: {
    "c-list": ComponentList,
    "c-show": ComponentShow,
  },
  data() {
    return {};
  },
  mounted() {}
};
</script>

<style scoped></style>
