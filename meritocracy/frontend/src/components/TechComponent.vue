<template>
	<div>
		tech :{{tech}}, name: {{tech.name}}
	</div>
</template>

<script>
	export default {
  		name: 'techComponent',
  		props: ['tech'],
  	}
</script>