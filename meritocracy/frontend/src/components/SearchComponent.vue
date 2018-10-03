<template>
	<div >
		<b-card no-body>
			<b-input-group>
				<b-form-input id="searchInput"
					type="text"
					v-model="searchInput"
					required
					v-on:input="sendSearchQueryEvent"
					:placeholder="'Search in '+ amounts._total +' technology components ...'  ">
				</b-form-input>
				<b-input-group-append>
					<b-button v-on:click="sendSearchQueryEvent"
						variant="secondary">
						Search
					<v-icon name="search" ></v-icon>
					</b-button>
					<b-button
						variant="secondary lg"
						:disabled="!filterOn"
						@click="clearFilters">
						Clear Filters
			    		<v-icon
			    			label="reset filters">
			    			<v-icon name="filter" scale="2"></v-icon>
			    			<v-icon name="ban" scale="2" color="orange"></v-icon>
			    		</v-icon>
					</b-button >
				</b-input-group-append>
			</b-input-group>
			<b-form-text id="inputLiveHelp">
			Type what you want to search for -technology name, use case, anything ...
			</b-form-text>
		</b-card>
		<b-card-group>

			<b-card 
				v-for="type in types"
				tag="article"
				class="card-lifecycle">
				<div slot="header" >
					<b-button 
						:variant="'outline-'+btnVariant(type)" 
						class="phase"
						@click="setPhase(type)"
						:pressed="phaseModel[type]" >
						<b-img rounded :src="images(type)" class="image-menu" top/>
						<p>{{type | capitalize}}</p>
						<b-badge pill>{{amountsForType[type]}}</b-badge>	
					</b-button>

				</div>

				<div class="card-text">
						<b-button-group vertical>
							<span
								v-for="item in itemsForType[type]" >
								<life-cycle 
									:id="item+'selector'" 
									:status="item" 
									v-on:selected="setLcQuery(item)"
									:isPressed.sync="lcModel[item]">	
								</life-cycle>
								<b-badge pill>{{amounts[item]}}</b-badge>	
							</span>
						</b-button-group>
					</div>
			</b-card>
		</b-card-group>

		<b-card style="card control-left " no-body>
			<div class="card-header">Search in Usecases <strong v-if="query">{{ query.tx | stringify }}</strong></div>
			<div style="card-body father">
				<sunburst-wrap 
					:tree="sunburstTree" 
					class="sunburst"
					v-on:nodeClicked="setUseCaseQuery"
				>
				</sunburst-wrap>
			</div>
		</b-card>
</div>

</template>

<script type="text/javascript">

import LifeCycle from '../components/LifeCycle.vue'
import lifeCycleMixin from '../mixins/lifeCycle.js'
  	import SunburstWrap from '../components/SunburstWrap.vue'



	export default {
		name:"searchComponent",
		props: {
			amounts:{ required: true},
			query: {required: true},
		},
		components: {
			LifeCycle,
        	SunburstWrap
		},
		mixins: [
			lifeCycleMixin
		],
		data () {
			return {
				searchInput: '',
				lcModel: this.$store.getters.lifeCycle.items.reduce( (acc, i) => ({...acc, [i.name]: false}), {}),
				//phase model represent the state of buttons that group lifecycles -it does not send its own events, but selects - deselects its group
				phaseModel: {}
			}
		},
		created() {
			this.$store.dispatch('fetchTaxonomy');
			
			this.phaseModel = this.types.reduce( (acc, i) => ({...acc, [i]:false }), {});
			//initialize array state for life cycle buttons
			this.query.lc.forEach( item => this.setLcQuery(item) );
			
		},
	    computed: {
	       taxonomyLevels: function() {
	      	return this.$store.getters.taxonomy.levels;
	      },
	      taxonomyTags: function() {
	      	return this.$store.getters.taxonomy.tags;

	      },
	      taxonomyTree () {
	      	return this.buildTree(this.taxonomyTags)
	      },
	      sunburstTree () {
	      	return this.buildTreeForSunburst(this.taxonomyTree)
	      },

	      filterOn(){
	      	return this.searchInput !== ''|| Object.values(this.lcModel).some( lcValue => lcValue ) || this.query.tx.length !== 0;
	      },
	      amountsForType(){
	      	return this.types.reduce( 
	      		(acc, t) => ({...acc, [t]: 
	      			this.itemsForType[t].reduce( (sum, lc) => (sum + this.amounts[lc]), 0)
	      	}), {})
	      }
	    },
	    filters: {
	      capitalize: function( lower) {
	        return lower.charAt(0).toUpperCase() + lower.substr(1);
	      }, 
	      stringify: function( list ){
	      	return list ? list.join('>'): list;

	      }
	    },
	    methods: {
	      images: function (type) {
	        return this.$store.state.phaseImages[type]
	      },
	      texts: function (type) {
	        return this.$options.phaseText[type]
	      },

	      sendSearchQueryEvent(queryString) {
	      	this.$emit('queryString', this.searchInput);
	      	this.query.string = queryString;
	      },
	      setUseCaseQuery( useCase ){
	      	this.query.tx = useCase.trail;
	      	//this.$emit(useCase, this.useCaseModel.trail);

	      },
	      setLcQuery (item, newValue = !this.lcModel[item]) {
	      	// have to update state here, since lcbutton is a child compponent that wraps a button
	      	this.lcModel[item] = newValue
	      	this.query.lc = Object.keys(this.lcModel).filter(item => this.lcModel[item])
	      	this.updateRoute()
	      },
	      // the phase button flips its group of lc buttons on/off
	      setPhase(type, newValue = ! this.phaseModel[type]){
	      	this.phaseModel[type] = newValue;
	      	this.itemsForType[type].forEach( item => this.setLcQuery(item, newValue));

	      },
	      save () {
	      	let sunburstTree = this.buildTreeForSunburst()
	      	console.log('Trying to save file')
	      	this.saveFile(sunburstTree)
	      },

	      clearFilters(){
	      	this.searchInput = '';
	      	//reset the query object
	      	this.sendSearchQueryEvent( this.searchInput);
	      	this.types.forEach( type => this.setPhase(type, false));
	      	this.query.tx=[];
	      	//reset sunburst to root

	      }

	    }
}

</script>

<style scoped>
.card-lifecycle {
  max-width: 95%;
  height: auto;
}

.image-menu {
    width: 96px;
    height: 96px;
    background-color: #ffffff;
    border-style: solid;
    border-width: thin;
    border-color: #aaaaaa;
    opacity: 1;
}

.sunburst {
    width: 400px;
    height: 400px;
    margin-top: 10px;
    position: relative;
  }

	.father {
	    position: relative;
	    width: 100%;
	    height: 100%;
	    display: flex;
	    justify-content: center;
	  }

		.control-left {
		 height: 100%;
	 }
	 .phase {
		min-width: 8em;
  		max-width: 8em;
	}
</style>
