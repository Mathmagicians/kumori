<template>
	<div class="my-2">
    <b-row>
      <b-col cols="5">
        <b-alert
          v-if="loading.tax"
          show
          variant="warning">
          Loading #techmenu taxonomies …
          <v-icon name="spinner" scale="3" spin/>
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
          <v-icon name="spinner" scale="3" spin/>
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
          <list-with-pagination 
            ref="pagination"
            :list-size="25" 
            v-bind:list-total="filteredTechComponents.length"
            v-bind:activeOrdinal="activeOrdinal"
            :button-panel-size="7">
            <tech-component
              slot-scope="props"
              v-if="props.isOn"
              :num="props.num"
              :tech="filteredTechComponents[props.listSeq]"
              v-bind:active="filteredTechComponents[props.listSeq].uid === activeId">
            </tech-component>
          </list-with-pagination>
        </div>
      </b-col>
    </b-row>
  </div>
</template>
<script>

  import TechComponent from '../components/TechComponent.vue'
  import SearchComponent from '../components/SearchComponent.vue'
  import ListWithPagination from '../components/ListWithPagination.vue'
  import lifeCycleMixin from '../mixins/lifeCycle.js'

  export default {
  	name: 'techComponentsList',
    beforeRouteUpdate (to, from, next) {
      this.activeId = this.findIdFromName(to.params.name);
      console.log(`active id ${this.activeId}, prop ${this.name}, param ${to.params.name}`)
      next();
    },
    props: ['name'],
  	data () {
    		return {
      			loading: {tech: true, tax: true, size: true},
            activeId: '',
            query: {
              string: '',
              lc: [],
              tx: []
            },
            fuzzySearchResults: [],
            listTotal: 0
    		}
		},
    props: {
      uid: {
        type: String,
        default: ''
      }
    },
    watch: {
      uid: function (newVal, oldVal) {
        this.activeId = newVal
      }
    },
    mixins: [
      lifeCycleMixin
    ],
		components: {
			TechComponent,
      SearchComponent,
      ListWithPagination
		},
		computed: {
       activeOrdinal(){
        return this.filteredTechComponents.findIndex( t => t.uid === this.activeId)
      },
  		techComponents () {
    		return this.$store.getters.tech
  		},
      taxonomyTags () {
       return this.$store.getters.taxonomy.tags
      },
      amounts () {
        let am = {_total: this.techComponents.length}
        this.$store.getters.lifeCycle.items.forEach(
          item => am = { ...am, [item.name]: this.techComponents.filter(t => t.status === item.name).length}
        )
        return am
      },
      filteredTechComponents () {
        return this.filterList(this.techComponents, this.query);
      },
      sunburstTree () {
        let flatListWithSizes = this.addSizesForTaxonomies(this.$store.getters.taxonomy.tags, this.techComponents)
        return ({
          name: '#techmenu',
          children: this.buildTree(flatListWithSizes)
        })
      }
		},
		created () { 
  		this.loading = {tech: true, tax: true}
      this.$store
        .dispatch('fetchTaxonomy')
        .then(taxonomy => { this.loading.tax = false })
  		this.$store.dispatch('fetchTechComponents')
    			.then(techComponents => { 
            this.loading.tech = false
             this.activeId = this.findIdFromName(this.name)
           })
      this.$store.dispatch('fetchTechSize')
        .then( size => { 
          this.listTotal = this.$store.getters.techSize
          this.loading.size = false
        })
		},
    filters: {
      techId (tech) {
        return 'tc-' + tech.uid;
      }
    },
    methods: {
      findIdFromName(name){
        const item = this.techComponents.find( t => t.name === name)
        return item ? item.uid : undefined
      },
      selectLifeCycle (list) {
        this.query.lc = list;
      },
      fuzzySearch (query, techComponentsList) {
          const options = {
            id: 'name',
            shouldSort: true,
            includeScore: true,
            includeMatches: true,
            threshold: 0.6,
            location: 0,
            distance: 50,
            maxPatternLength: 32,
            minMatchCharLength: 2,
            keys: [
              'name',
              'description',
              'usecases'
            ]
          };
          if (this.query.string) {
             this.$search(query, this.techComponents, options)
            .then(results => this.fuzzySearchResults = results);
          }
        },
        filterList (techList, query) {
          // const isQueryStringIncluded = (tech,query) => query.string === '' || tech.name.toLowerCase().includes(query.string.toLowerCase());
          const isQueryStringInFuzzySearch = (tech, query) => query.string === '' || this.fuzzySearchResults.find(fuzzy => fuzzy.item === tech.name);
          const isLifeCycleIncluded = (tech, query) => query.lc.length === 0 || query.lc.includes(tech.status);
          const isUseCaseIncluded = (tech, query) => query.tx.length === 0 || query.tx.every(tx => tech.tags ? tech.tags.includes(tx) : false);
          const filters = [isQueryStringInFuzzySearch, isLifeCycleIncluded, isUseCaseIncluded];
          // apply all the filters to the list
          return techList.filter(e => filters.every(f => f.call( null, e, query)));
        },
        createNewTech() {
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
