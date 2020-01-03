<template>
<b-container fluid>
  <b-row>
    <b-col>
      <h1>{{ title }}</h1>
    </b-col>
  </b-row>
  <b-row>
    <b-col>
      <slot name="left" />
    </b-col>
    <b-col>
      <slot name="right" />
    </b-col>
  </b-row>
</b-container>
</template>

<script>
export default {
  name: "Split",
  props: {
    title: {
      type: String,
      default: ''
    }
  },
};
</script>

<style scoped></style>
