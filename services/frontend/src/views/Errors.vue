<template>
	<b-alert 
		show
		variant="danger">
		<v-icon name="times" scale="2">
		</v-icon>
		 <h4 class="alert-heading">Error code: {{code}}</h4>

		Uuups ... something went wrong here  ... I was just trying to find data for {{asset}}, and received error code <b>{{code}}</b>

	</b-alert>
</template>

export default {
	name: 'errors',
	props: {
		code: {
			type: String,
			default: '???'
		}, 
		asset: {
			type: String,
			default: '???'
		}
    },
}
