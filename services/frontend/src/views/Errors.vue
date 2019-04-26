<template>
  <b-alert show variant="danger">
    <v-icon name="times" scale="2" />
    <h4 class="alert-heading">Error code: {{ code }}</h4>

    Uuups ... something went wrong here ... I was just trying to find data for
    {{ asset }}, and received error code <b>{{ code }}</b>
  </b-alert>
</template>

<script>
import Icon from "vue-awesome/components/Icon";
import "vue-awesome/icons/times";
export default {
  name: "errors",
  components: {
    "v-icon": Icon
  },
  props: {
    code: {
      type: String,
      default: "???"
    },
    asset: {
      type: String,
      default: "???"
    }
  }
};
</script>
<style scoped></style>
