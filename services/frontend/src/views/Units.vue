<template>
<split title="Units">
  <template v-slot:left>
    <unit-list /></template>
  <template v-slot:right>
    <unit-show /></template>
</split>
</template>

<script>
import Split from "@/components/Split";
import UnitList from "@/components/unit/List";
import UnitShow from "@/components/unit/Show";
export default {
  name: "list",
  components: {
    "split": Split,
    "unit-list": UnitList,
    "unit-show": UnitShow
  },
  data() {
    return {};
  },
  mounted() {}
};
</script>

<style scoped></style>
