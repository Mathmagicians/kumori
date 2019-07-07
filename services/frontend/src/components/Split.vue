<template>
<b-container fluid>
  <b-row>
    <b-col>
      <h1>{{title}}</h1>
    </b-col>
  </b-row>
  <b-row>
    <b-col>
      <slot name="left"></slot>
    </b-col>
    <b-col>
      <slot name="right"></slot>
    </b-col>
  </b-row>
</b-container>
</template>

<script>
export default {
  name: "split",
  props: ['title'],
};
</script>

<style scoped></style>
