<template>
	<b-alert 
		show
		variant="danger">
		<v-icon name="times" scale="2">
		</v-icon>
		Uuups ... something went wrong here  ... I was just trying to find data for {{asset}}, and received error code <b>{{error}}</b>

	</b-alert>
</template>

export default {
	name: 'errors'
}
