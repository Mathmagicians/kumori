<template>
	<div >
		<b-card no-body>
			<b-input-group>
				<b-form-input id="searchInput"
					type="text"
					v-model.sync="searchInput"
					required
					v-on:change="sendSearchQueryEvent"
					:placeholder="'Search in '+ amounts.components +' technology components ...'  ">
				</b-form-input>
				<b-input-group-append>
					<b-button v-on:click="sendSearchQueryEvent"
						variant="secondary">
						Search
					<v-icon name="search" ></v-icon>
					</b-button>
				</b-input-group-append>
			</b-input-group>
			<b-form-text id="inputLiveHelp">
			Type what you want to search for -technology name, use case, anything ...
			</b-form-text>
		</b-card>

		<b-card-group>
		<b-card v-for="type in types"
			tag="article"
			class="card-lifecycle">
			<div slot="header" >
				<b-button :variant="'outline-'+btnVariant(type)">
					<b-img rounded :src="images(type)" class="image-menu" top/>
					{{type | capitalize}}
				</b-button>
				<b-badge pill>12</b-badge>



			</div>

			<div class="card-text">
					<b-button-group vertical>
						<life-cycle v-for="item in itemsForType[type]" :status="item"></life-cycle>
					</b-button-group>
				</div>
		</b-card>
	</b-card-group>

		<b-card style="card control-left " no-body>
			<div class="card-header">Usecases</div>
			<div style="card-body father">
				<sunburst-wrap :tree="sunburstTree" class="sunburst"></sunburst-wrap>
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
			amounts:{ required: false}
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
				filterOn: true
			}
		},
		created() {
			this.$store.dispatch('fetchTaxonomy');
		},
	    computed: {
	      types: function() {
	        let temp = this.$store.state.lifeCycle.items.map( item => item.type).filter((v, i, a) => a.indexOf(v) === i);
	        return temp;

	      },
	      itemsForType: function() {
	        const namesForType = type =>  this.$store.state.lifeCycle.items.filter( item => item.type === type).map( item => item.name);
	        const myMap = new Map();
	        this.types.forEach( type =>  myMap[type] = namesForType(type));
	        return myMap;
	      },
	      taxonomyLevels: function() {
	      	return this.$store.state.taxonomy.levels;
	      },
	      taxonomyTags: function() {
	      	return this.$store.state.taxonomy.tags;
	      },
	      taxonomyTree() {
	      	return this.buildTree( this.taxonomyTags );
	      },
	      sunburstTree(){
	      	return this.buildTreeForSunburst( this.taxonomyTree );
	      }
	    },
	    filters: {
	      capitalize: function( lower) {
	        return lower.charAt(0).toUpperCase() + lower.substr(1);
	      }
	    },
	    methods: {
	      images: function(type) {
	        return this.$store.state.phaseImages[type];
	      },
	      texts: function(type) {
	        return this.$options.phaseText[type];
	      },
	      sendSearchQueryEvent(query) {
	      	return this.$emit('query', this.searchInput);
	      },
	      save(){
	      	let sunburstTree = this.buildTreeForSunburst();
	      	console.log("Trying to save file");
	      	this.saveFile( sunburstTree );
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
    width: 64px;
    height: 64px;
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
</style>
