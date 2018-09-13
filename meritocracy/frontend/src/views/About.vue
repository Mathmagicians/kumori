<template>
<div id="about">
  <b-alert show variant="secondary">Here, you can read more about #techmenu, the process, the life cycle, the status.</b-alert>
  <div id="lifecycle">
  	<b-card-group deck>
  	<b-card title="Buy"
          img-src="../assets/buy.svg"
          img-alt="Image"
          img-top
          tag="article"
          style="max-width: 20rem;"
          class="mb-2">
    	<p class="card-text">
      		Some quick example text to build on the card title and make up the bulk of the card's content.
    	</p>
    	
      <b-card-group deck>
        <b-card v-for="item in items">{{item.name}}</b-card>
      </b-card-group>

  	</b-card>
  	<b-card title="Hold"
          img-src="../assets/service.svg"
          img-alt="Image"
          img-top
          tag="article"
          style="max-width: 20rem;"
          class="mb-2">
    	<p class="card-text">
      		Some quick example text to build on the card title and make up the bulk of the card's content.
    	</p>
    	<b-button href="#" variant="primary">Go somewhere</b-button>
  	</b-card>
  	<b-card title="Sell"
          img-src="../assets/exterminator.svg"
          img-alt="Image"
          img-top
          tag="article"
          style="max-width: 20rem;"
          class="mb-2">
    	<p class="card-text">
      		Some quick example text to build on the card title and make up the bulk of the card's content.
    	</p>
    	<b-button href="#" variant="primary">Go somewhere</b-button>
  	</b-card>
  </b-card-group>
  </div>
  <div id="taxonomy">
  	
  </div>
</div>
</template>

<script>
  
  export default {
    name: 'about',
    computed: {
        items(type) {
          return this.$store.state.lifeCycle.items
        }
      }
  }
</script>