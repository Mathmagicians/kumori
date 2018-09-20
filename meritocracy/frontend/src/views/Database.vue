<template>
<div>
  <h1>Demo access to database</h1>
  <b-button v-on:click="getOne">Fetch data</b-button>
  <div v-if="data != null">{{data}}</div>
  <div v-if="data == null">No data</div>
</div>
</template>

<script>
export default {
  name: 'database',
  data: function () {
    return {
      data: null
    }
  },
  methods: {
    getOne: function () {
      this.$http.get('http://127.0.0.1:3000/components?limit=1').then(response => {
        this.data = response.body;
      }, response => {
        this.data = "Found nothing";
      });
    }
  }
}
</script>
