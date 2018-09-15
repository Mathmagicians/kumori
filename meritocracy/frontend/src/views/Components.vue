<template>
	<div >
    	<span v-if="loading">Loading #techmenu components … <v-icon name="spinner" scale="2" spin/></span>
    	<ul
      		v-else
      		class="components">
       		#techmenu is happily governing <b> {{techComponents.length}}. </b> components.
  			<p>Let me tell you more about <strong>{{ $route.params.name }}</strong></p>
      		<li
        		v-for="component in techComponents"
        		:key="component.title"
        		class="tech-component">
          		<h1>{{ component.name }}</h1>
      		</li>
    	</ul>
  </div>
</template>

<script>
export default {
  data () {
    return {
      loading: false
    }
  },

  computed: {
    techComponents () {
      return this.$store.state.techComponents
    }
  },

  created () {
    this.loading = true
    this.$store.dispatch('fetchTechComponents')
      .then(techComponents => {
        this.loading = false
      })
  }
}
</script>
