<template>
	<div>
  		

  		
        <p>array syntax {{img['buy']}}</p>
  		<p> dot syntax {{img.buy}}</p>
    	<b-card :title="img['buy']"
          img-src="../assets/buy.svg">
      	</b-card>
     
      	<b-card :title="img['buy']"
          :img-src="img['buy']">
      	</b-card>

       	<b-card :title="img['buy']"
          :img-src="img.buy">
      	</b-card>
     </div>
</template>

<script>
	export default {
		name: 'home',
		data() {
      		return {
        		el: "#about",
        		img: {
					'buy': '../assets/buy.svg',
					'hold': '../assets/service.svg', 
					'sell': '../assets/exterminator.svg', 
					'maybe': '../assets/community.svg'
				}
			}
        }
	}
</script>

