<template>
	<div >
    	<b-alert show variant="warning"
    		v-if="loading">Loading #techmenu components … 
    		<v-icon name="spinner" scale="2" spin/></v-icon>
    	</b-alert>
    	<ul
      		v-else
      		class="components">
      		<b-alert show variant="secondary">
      			#techmenu is happily governing <b> {{techComponents.length}}. </b> components.
      		</b-alert>
       		
  			<li
        		v-for="component in techComponents"
        		:key="component.title"
        		class="tech-component">
          		<h1>{{ component.name }}, {{component.scopes}}</h1>
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
