<template>
	<b-card title="type"
          img-src="img"
          img-alt="Image"
          img-top
          tag="article"
          style="max-width: 95%; max-height: 95%;"
          class="mb-2">
    	<div v-html="type" class="card-text">
    	</div>
  	</b-card>
	
</template>

<script>
	
	export default {
		name: 'lifeCycle',
		props: ['type', 'img'],
 
	}
	
</script>