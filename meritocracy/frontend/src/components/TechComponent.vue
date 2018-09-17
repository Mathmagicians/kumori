<template>
	<div>
		<b-card>
			<p slot="header" v-b-toggle="accordionId">
				{{tech.name}} 
				<life-cycle :status="tech.status"></life-cycle>
			</p>
			<b-collapse :id="accordionId" accordion="tech">
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
        	</b-collapse>
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
  		computed: {
  			accordionId: function(){
  				return 'accordion-' + this.tech.uid; 
  			}
  		}
  	}
</script>