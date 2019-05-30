<template>
  <b-container fluid>
  <b-row>
    <b-col><c-list /></b-col>
    <b-col><c-show /></b-col>
  </b-row>
  <edit-component />
</b-container>
</template>

<script>
import ComponentList from "@/components/component/List";
import ComponentShow from "@/components/component/Show";
import EditComponent from "@/components/component/Edit";
export default {
  name: "list",
  components: {
    "c-list": ComponentList,
    "c-show": ComponentShow,
    "edit-component": EditComponent,
  },
  data() {
    return {};
  },
  mounted() {}
};
</script>

<style scoped></style>
