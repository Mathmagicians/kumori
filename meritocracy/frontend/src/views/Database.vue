<template>
<div>
  <h1>Demo access to database</h1>
  <b-button v-on:click="getOne">Fetch data</b-button>
  <div v-if="data != null">
    <dl>
      <dt>Uid</dt>
      <dd>{{data.uid}}</dd>
      <dt>Name</dt>
      <dd>{{data.name}}</dd>
      <dt>Description</dt>
      <dd>{{data.description}}</dd>
      <dt>Status</dt>
      <dd>{{data.status}}</dd>
      <dt>Tags</dt>
      <dd>{{data.tags}}</dd>
      <dt>Licenses</dt>
      <dd>{{data.licenses}}</dd>
      <dt>Links</dt>
      <dd>{{data.links}}</dd>
      <dt>Usecases</dt>
      <dd>{{data.usecases}}</dd>
      <dt>Scopes</dt>
      <dd>{{data.scopes}}</dd>
    </dl>
  </div>
  <div v-if="data == null">No data</div>
</div>
</template>

<script>
export default {
  name: 'database',
  data: function() {
    return {
      data: null
    }
  },
  methods: {
    getOne: function() {
      this.$http.get('http://0.0.0.0:3000/w_components').then(response => {
        this.data = response.body[6];
      }, response => {
        this.data = "Found nothing";
      });
    }
  }
}
</script>
