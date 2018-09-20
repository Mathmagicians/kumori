<template>
	<div>
    <b-alert show variant="warning">
      <v-icon name="keyboard" scale="2"/></v-icon>
      Work in progress - awesome content on the way ...
    </b-alert>

    <search-component :amounts="{components: 42}"></search-component>

  </div>
</template>

<script>

  import SearchComponent from '../components/SearchComponent.vue'
  import SunburstWrap from '../components/SunburstWrap.vue'


  export default {
  	name: 'home',
    components: {
        SearchComponent,
        SunburstWrap
      },
  	
  }

</script>

