<template>
	<div class="mb1">
    <b-row>
      <b-col cols="5">
        <b-alert 
          v-if="loading.tax"
          show 
          variant="warning">
          Loading #techmenu taxonomies … 
          <v-icon name="spinner" scale="3" spin/></v-icon>
        </b-alert>
        <search-component 
          v-else
          :amounts="amounts" 
          v-bind:query="query" 
          v-bind:tree="sunburstTree"
          v-on:queryString="fuzzySearch($event)"
        >
        </search-component>
      </b-col>
      <b-col cols="7">
        <b-alert 
          v-if="loading.tech"
          show 
          variant="warning">
          Loading #techmenu components … 
          <v-icon name="spinner" scale="3" spin/></v-icon>
        </b-alert>
        <div
          v-else>
          <b-alert 
            show variant="secondary">
            <b-button id="createTechButton"
              class="status-floater btn-round"
              v-if="$store.getters.isEditOn"
              variant="light"
              @click="createNewTech">
              <v-icon name="plus" 
              color="green"/>
            </b-button>
            <b-popover 
              target="createTechButton"
              triggers="hover focus"
              title="Create New Tech"
              content="Add a new technology to #techmenu"/>
            <p>#techmenu is happily governing 
            <b-badge variant="secondary">{{techComponents.length}}</b-badge>
             technologies.
            </p>
            <p 
              v-if="filteredTechComponents.length !== techComponents.length">
                Your search returned 
                <b-badge variant="secondary">{{filteredTechComponents.length}}</b-badge>
                technologies.
            </p>
          </b-alert>
      		<tech-component 
            v-for="component in filteredTechComponents"
            :key="component.name"
            v-bind:tech="component" 
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
  import lifeCycleMixin from '../mixins/lifeCycle.js'
  
  
  const lifeCycleFilter = (tech, query) => query.lc.length === 0 || query.lc.includes(tech.status)
  const useCaseFilter = (tech, query) => query.tx.length === 0 || query.tx.every( tx => tech.tags? tech.tags.includes( tx ):false)
          

  export default {
  	name: "techComponentsList",
    beforeRouteUpdate(to, from, next) {
      this.activeId = to.params.uid;
      next();
    },
  	data () {
    		return {
      			loading: {tech: false, tax: false},
            activeId: '', 
            query: {
              string: '',
              lc: [],
              tx: []
            },
            fuzzySearchResults: []
    		}
		},
    props: {
      uid: {
        type: String,
        default: ''
      }
    },
    mixins: [
      lifeCycleMixin
    ],
    watch: { 
        uid: function(newVal, oldVal) { 
          this.activeId = newVal
        }
      },
		components: {
			TechComponent,
      SearchComponent
		},
		computed: {
  		techComponents () {
    		return this.$store.getters.tech
  		},
      taxonomyTags () {
        return this.$store.getters.taxonomy.tags
      },
      amounts () {
        let am = {_total: this.techComponents.length}
        this.$store.getters.lifeCycle.items.forEach( 
          item => am = { ...am, [item.name]: this.techComponents.filter( t => t.status === item.name ).length}
        )
        return am
      },
      filteredTechComponents() {
        return this.filterList( this.techComponents, this.query );           
      }, 
      sunburstTree(){
        let flatListWithSizes = this.addSizesForTaxonomies( this.taxonomyTags, this.techComponents)
        return ({ name: "#techmenu", children: this.buildTree( flatListWithSizes )})
      },
		},
		created () {
      this.activeId = this.uid;
  		this.loading = {tech: true, tax: true}
      this.$store
        .dispatch('fetchTaxonomy')
        .then(taxonomy => { this.loading.tax = false})
  		this.$store.dispatch('fetchTechComponents')
    			.then(techComponents => { this.loading.tech = false})
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
        },
        createNewTech(){
          this.$router.push({ name: 'create'});
       }
    }
  }
</script>

<style scoped>
.status-floater {
  float: right;
}

.btn-round {
  border-radius: 50px;
}
</style>
