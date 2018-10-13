<template>
	<div>
		<b-card no-body class="mb-2">
			<b-input-group>
				<b-form-input
					title="Type what you want to search for - technology name, use case, anything ..."
					id="searchInput"
					type="text"
					v-model.sync="searchInput"
					required
					v-on:input="sendSearchQueryEvent"
					:placeholder="'Search in '+ amounts._total +' technology components ...'  ">
				</b-form-input>
				<b-input-group-append>
					<b-button
						title="Search"
						v-on:click="sendSearchQueryEvent"
						variant="secondary">
						<v-icon name="search"/>
					</b-button>
					<b-button
						title="Clear Filters"
						variant="secondary"
						:disabled="!filterOn"
						@click="clearFilters">
						<v-icon
			    		label="reset filters">
			    		<v-icon name="filter" scale="1"/>
			    		<v-icon name="ban" scale="1" color="orange"/>
			    	</v-icon>
					</b-button >
				</b-input-group-append>
			</b-input-group>
		</b-card no-body>
		<b-card-group class="mb-2">
			<b-card
				overlay
				v-for="type in types"
				tag="article"
				class="card-lifecycle"
				>
				<div class="card-body text-left">
					<b-img
						fluid
						class="image-lc"
						:src="images(type)"/>
					<b-button
						:variant="'outline-'+btnVariant(type)"
						class="phase"
						@click="setPhase(type)"
						:pressed="phaseModel[type]" >
						{{type | capitalize}}
						<b-badge
							pill
							size="lg"
							:variant="btnVariant(type)">
							{{amountsForType[type]}}
						</b-badge>
					</b-button>

					<b-button-group vertical>
						<span
							style="width: 10rem;margin: 2px;"
							v-for="item in itemsForType[type]" >
							<life-cycle
								:id="item+'selector'"
								ispopup
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

		<b-card style="card control-left" no-body>
			<div class="card-header">Search in Usecases <strong v-if="query">{{ query.tx | stringify }}</strong></div>
			<div style="card-body father">
				<sunburst-wrap
					ref="sunburst"
					:tree="tree"
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
			tree: {required: true}
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
				phaseModel: {},
			}
		},
		created() {
			this.loading = true

			this.phaseModel = this.types.reduce( (acc, i) => ({...acc, [i]:false }), {})
			//initialize array state for life cycle buttons
			this.query.lc.forEach( item => this.setLcQuery(item) )
		},
	    computed: {
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
	      texts: function(type) {
	        return this.$options.phaseText[type];
	      },
	      sendSearchQueryEvent(queryString) {
	      	this.$emit('queryString', this.searchInput);
	      	this.query.string = queryString;
	      	this.updateRoute()
	      },
	      setUseCaseQuery( useCase ){
	      	this.query.tx = useCase.trail;
	      	this.updateRoute()
	      },
	      setLcQuery(item, newValue = !this.lcModel[item] ){
	      	//have to update state here, since lcbutton is a child compponent that wraps a button
	      	this.lcModel[item] = newValue;
	      	this.query.lc = Object.keys(this.lcModel).filter( item =>  this.lcModel[item]);
	      	this.updateRoute();
	      },
	      // the phase button flips its group of lc buttons on/off
	      setPhase(type, newValue = ! this.phaseModel[type]){
	      	this.phaseModel[type] = newValue;
	      	this.itemsForType[type].forEach( item => this.setLcQuery(item, newValue));
	      },
	      save(){
	      	let sunburstTree = this.buildTreeForSunburst();
	      	console.log("Trying to save file");
	      	this.saveFile( sunburstTree );
	      },
	      updateRoute() {
	      	//todo dont push empty query parameters!
	      	let prettyQuery = {}
	      	if( this.query.string ) prettyQuery.string = this.query.string
	      	if( this.query.tx.length > 0) prettyQuery.tx = this.query.tx
	      	if( this.query.lc.length > 0) prettyQuery.lc = this.query.lc
	      	this.$router.push({path: '/components/search', query: prettyQuery });
	      },
	      clearFilters(){
	      	this.searchInput = ''
	      	//reset the query object
	      	this.sendSearchQueryEvent( this.searchInput)
	      	this.types.forEach( type => this.setPhase(type, false))
	      	this.query.tx=[]
	      	this.$refs.sunburst.resetPath()
	      	this.updateRoute()
	      }
	    }
	}

</script>

<style scoped>
.card-lifecycle {
  height: 20rem;
  background-color: white;
}

.image-lc {
	width: 100%;
    height: 8rem;
    background-color: white;
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
		 width: 100%;
	 }
	 .phase {
		min-width: 8em;
  		max-width: 8em;
  		margin: 2px;
	}
</style>
