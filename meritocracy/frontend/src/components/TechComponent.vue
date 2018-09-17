<template>
	<div>
		<b-card>
			<p slot="header">
				{{tech.name}} {{tech.status}}
				<life-cycle :status="tech.status"></life-cycle>
			</p>
			<p class="card-text">
				{{tech}} 
			</p>
		
			<div slot="footer">
				<b-button variant="outline-secondary sm" class="btn-round">
            		<v-icon name="heart" scale="1"/></v-icon>
        		</b-button>
        		<b-button variant="outline-secondary sm" class="btn-round">
            		<v-icon name="fire" scale="1"/></v-icon>
        		</b-button>
        		<b-button  variant="outline-secondary sm" class="btn-round">
            		<v-icon name="comment" scale="1"/></v-icon>
        		</b-button>
        	</div>
        </b-card>
	</div>
</template>

<script>

	import LifeCycle from '../components/LifeCycle.vue'

	export default {
  		name: 'techComponent',
  		components: {
  			LifeCycle
  		},
  		props: ['tech'],
  	}
</script>