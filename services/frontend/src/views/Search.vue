<template>
<split title="Search">
  <template v-slot:left>
    Missing</template>
  <template v-slot:right>
Missing</template>
</split>
</template>

<script>
import Split from "@/components/Split";
export default {
  name: "search",
  data() {
    return {
    };
  },
  components: {
    "split": Split,
  },
  methods: {}
};
</script>

<style scoped>
</style>
