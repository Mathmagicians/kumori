<template>
  <div class="home">
    <b-jumbotron
      header="Kumori"
      lead="Rational technology decisions - based on idea meritocracy"
    >
      <b-img
        class="move_up"
        :src="require('../assets/kumori.svg')"
        width="100%"
        height="200"
      />
    </b-jumbotron>
  </div>
</template>

<script>
export default {
  name: "home"
};
</script>

<style scoped>
.move_up {
  position: relative;
  top: -220px;
  left: 250px;
}
</style>
