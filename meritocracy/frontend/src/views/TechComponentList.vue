<template>
	<div class="mb1">
    <b-alert show variant="secondary">
            #techmenu is happily governing <b>{{techComponents.length}}</b> components. 
            {{query.tx}}
          </b-alert>
    <b-row>
      <b-col cols="5">
        <search-component 
          :amounts="amounts" 
          v-bind:query="query" 
          v-on:queryString="fuzzySearch($event)"
        >
        </search-component>
      </b-col>
      <b-col cols="7">
      	<b-alert 
          v-if="loading"
          show 
          variant="warning">
          Loading #techmenu components … 
      		<v-icon name="spinner" scale="3" spin/></v-icon>
      	</b-alert>
        <div
          v-else>
      		<tech-component 
            v-for="component in filteredTechComponents"
            :key="component.name"
            v-bind:id="component | techId" 
            :tech="component" 
            :active="component.uid === activeId">    
          </tech-component>
        </div>
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
        return this.filterList( this.techComponents, this.query );           
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
      fuzzySearch( query, techComponentsList ){
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
              "description",
              "usecases"
            ]
          };
          if( this.query.string) {
             this.$search(query, this.techComponents, options)
            .then(results => this.fuzzySearchResults = results);
          }
        },
        filterList( techList, query ){
          //const isQueryStringIncluded = (tech,query) => query.string === '' || tech.name.toLowerCase().includes(query.string.toLowerCase());
          const isQueryStringInFuzzySearch = (tech, query) => query.string === '' || this.fuzzySearchResults.find( fuzzy => fuzzy.item === tech.name );
          const isLifeCycleIncluded = (tech, query) => query.lc.length === 0 || query.lc.includes(tech.status);
          const isUseCaseIncluded = (tech, query) => query.tx.length === 0 || query.tx.every( tx => tech.tags? tech.tags.includes( tx ):false);
          const filters = [isQueryStringInFuzzySearch, isLifeCycleIncluded, isUseCaseIncluded];
          //apply all the filters to the list
          return techList.filter( e => filters.every( f =>  f.call( null, e, query)));   
        }
    }
  }
</script>
