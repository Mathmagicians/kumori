<template>
	<div>
    <b-alert show variant="warning">
      <v-icon name="keyboard" scale="2"/></v-icon>
      Work in progress - awesome content on the way ...
    </b-alert>

    <search-component></search-component>

  </div>
</template>

<script>

import SearchComponent from '../components/SearchComponent.vue'

	export default {
		name: 'home',
    components: {
        SearchComponent
      },
		data() {
      		return {
        		el: "#about",
        		img: {
					'buy': require('../assets/buy.svg'),
					'hold': require('../assets/service.svg'), 
					'sell': require('../assets/exterminator.svg'), 
					'maybe': require('../assets/exterminator.svg')
				}
			}
        }
	}
</script>

