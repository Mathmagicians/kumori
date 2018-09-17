<template>
	<div >
    	<b-alert show variant="warning"
    		v-if="loading">Loading #techmenu components … 
    		<v-icon name="spinner" scale="2" spin/></v-icon>
    	</b-alert>
    	<b-list-group
      		v-else
      		class="components">
      		<b-alert show variant="secondary">
      			#techmenu is happily governing <b>{{techComponents.length}}</b> components.
      		</b-alert>
       		
  			<b-list-group-item
        		v-for="component in techComponents"
        		:key="component.name"
        		class="tech-component">
          		<tech-component :tech="component"></tech-component>
      		</b-list-group-item>
    	</b-list-group>
  </div>
</template>

<script>

	import TechComponent from '../components/TechComponent.vue'

	export default {
		name: "techComponentsList",
		data () {
    		return {
      			loading: false
    		}
  		},
  		components: {
  			TechComponent
  		},
  		computed: {
    		techComponents () {
      			return this.$store.state.techComponents
    		}
  		},
  		created () {
    		this.loading = true
    		this.$store.dispatch('fetchTechComponents')
      			.then(techComponents => { this.loading = false})
  		}
	}
</script>
