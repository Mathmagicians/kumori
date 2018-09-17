<template>
	<div>
    <b-alert show variant="warning">
      <v-icon name="keyboard" scale="2" pulse/></v-icon>
      Work in progress - awesome content on the way ...
    </b-alert>
  </div>
</template>

<script>

import LifeCycle from '../components/LifeCycle.vue'

	export default {
		name: 'home',
    components: {
        LifeCycle
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

