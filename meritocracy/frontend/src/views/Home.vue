<template>
	<div>

  1. exp <life-cycle status="experimental"></life-cycle>
        2. dont  <life-cycle status="dontuse"></life-cycle>
        3.  empty <life-cycle status=""></life-cycle>
        4. wrong <life-cycle status="wrong"></life-cycle>
  		

       	<b-card :title="img['buy']"
          :img-src="img.buy">
      	</b-card>
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

