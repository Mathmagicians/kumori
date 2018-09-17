<template>
	<div :id="id">
		<b-card>
			<p slot="header" v-b-toggle="accordionId">
				<b-button v-on:click="changeRoute" variant="link lg">{{tech.name}}</b-button>
				<life-cycle :status="tech.status"></life-cycle>
			</p>
			<b-collapse :id="accordionId" accordion="tech" v-on:show="changeRoute" v-on:click="changeRoute" :visible="active?active:false">
				<div>
					<p class="card-text">
						{{tech}} 
					</p>
					<div slot="footer" class="card-footer">
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
  		props: {
  			id: { type: String, required: true},
  			tech: { type: Object, required: true}, 
  			active: {type: Boolean, default: false}
  		},
  		computed: {
  			accordionId: function(){
  				return 'accordion-' + this.tech.uid; 
  			}
  		}, 
  		methods: {
  			changeRoute: function() {
  				this.$router.push('/components/'+ this.tech.uid);
  			}
  		}
  	}
</script>