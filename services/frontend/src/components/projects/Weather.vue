<template>
<b-img :src="require('../../assets/weather0' + state + '.svg')" :width="size" :height="size" />
</template>

<script>
export default {
  name: "Weather",
  props: {
    state: {
      type: Number,
      default: 1,
      validator: function (value) {
        return [1, 2, 3, 4, 5].indexOf(value) !== -1;
      }
    },
    size: {
      type: Number,
      default: 32
    }
  }
};
</script>

<style scoped></style>
