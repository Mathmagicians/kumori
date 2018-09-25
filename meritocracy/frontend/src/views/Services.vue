<template>
	<div>
		<b-alert show variant="warning">
			<v-icon name="keyboard" scale="2" pulse/>
			Work in progress - awesome content on the way ...
		</b-alert>
  		<b-alert show variant="secondary">
  			Services are technologies implemented.
  			Overview of what we have, what is good, what should be improved.
  		</b-alert>
  		<b-alert show variant="warning"
    		v-if="loading">Loading #techmenu services …
    		<v-icon name="spinner" scale="2" spin/>
    	</b-alert>
    	<b-list-group
      		v-else
      		class="components">
      		<b-alert show variant="secondary">
      			#techmenu is happily governing <b>{{services.length}}</b> services.
      		</b-alert>

  			<b-list-group-item
        		v-for="service in services"
        		:key="service.name"
        		class="tech-component">
          		{{ service }}
      		</b-list-group-item>
    	</b-list-group>
	</div>
</template>

<script>
export default {
  name: 'services',
  data () {
    		return {
      			loading: false
    		}
  		},
  		computed: {
    		services () {
      			return this.$store.state.services
    		}
  		},
  		created () {
    		this.loading = true
    		this.$store.dispatch('fetchServices')
      			.then(services => { this.loading = false })
  		}
}
</script>
