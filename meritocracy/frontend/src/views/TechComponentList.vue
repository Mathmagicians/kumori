<template>
	<div >
    <b-alert show variant="secondary">
            #techmenu is happily governing <b>{{techComponents.length}}</b> components. 
          </b-alert>
    <b-row>
      <b-col cols="4">
        <search-component :amounts="amounts" v-on:query="search"></search-component>
      </b-col>
      <b-col>
    	<b-alert show variant="warning"
    		v-if="loading">Loading #techmenu components … 
    		<v-icon name="spinner" scale="2" spin/></v-icon>
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
            queryString: ''
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
        return this.techComponents.filter(
            tech => {  return tech.name.toLowerCase().includes(this.queryString.toLowerCase()) }
          );
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
      search( queryString ){
        this.queryString = queryString;
      }
    }
  }
</script>
