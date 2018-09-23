<template>
	<div class="mb1">
    <b-alert show variant="secondary">
            #techmenu is happily governing <b>{{techComponents.length}}</b> components. 
            {{query}}
            <b-button @click="fuzzySearch(query.string)"> try fuzzy search
            </b-button>
            {{fuzzySearchResults}}
          </b-alert>
    <b-row>
      <b-col cols="5">
        <search-component :amounts="amounts" v-bind:query="query" ></search-component>
      </b-col>
      <b-col cols="7">
      	<b-alert show variant="warning"
      		v-if="loading">Loading #techmenu components … 
      		<v-icon name="spinner" scale="3" spin/></v-icon>
      	</b-alert>
      	<b-list-group
        		v-else
        		class="components">
    			<b-list-group-item
          		v-for="component in filteredTechComponents"
          		:key="component.name"
          		class="tech-component">
            		<tech-component v-bind:id="component | techId" :tech="component" :active="component.uid === activeId"></tech-component>
        		</b-list-group-item>
      	</b-list-group>
      </b-col>
    </b-row>
  </div>
</template>

<script>

  import TechComponent from '../components/TechComponent.vue'
  import SearchComponent from '../components/SearchComponent.vue'

  export default {
  	name: "techComponentsList",
    beforeRouteUpdate (to, from, next) {
      this.activeId = to.params.uid;
      next();
    },
  	data () {
    		return {
      			loading: false,
            activeId: '', 
            query: {
              string: '',
              lc: [],
              tx: []
            },
            fuzzySearchResults: []
    		}
		},
		components: {
			TechComponent,
      SearchComponent
		},
		computed: {
  		techComponents () {
    			return this.$store.state.techComponents
  		},
      amounts () {
        let am =  {components: this.techComponents.length};
        return am;
      },
      filteredTechComponents() {
        const isQueryStringIncluded = (tech) => tech.name.toLowerCase().includes(this.query.string.toLowerCase());
        const isLifeCycleExcluded = (tech) => !this.query.lc.includes(tech.status);
        const filters = [isQueryStringIncluded, isLifeCycleExcluded];
       //apply all the filters to the list
        return this.techComponents.filter( e => filters.every( f =>  f.call( null, e)));           
      }
		},
		created () {
      this.activeId = this.$route.params.uid;
  		this.loading = true;
  		this.$store.dispatch('fetchTechComponents')
    			.then(techComponents => { this.loading = false});
		},
    filters: {
      techId (tech) {
        return 'tc-'+tech.uid;
      }
    },
    methods: {
      selectLifeCycle( list){
        this.query.lc = list; 
      },
      fuzzySearch( query ){
          console.log("trying fuzzy search");
          const options = {
            id: "name",
            shouldSort: true,
            includeScore: true,
            includeMatches: true,
            threshold: 0.6,
            location: 0,
            distance: 50,
            maxPatternLength: 32,
            minMatchCharLength: 2,
            keys: [
              "name",
              "description"
            ]
          };
          this.$search(this.query.string, this.techComponents, options).then(results => {
            this.fuzzySearchResults = results
          })
        }
    }
  }
</script>
