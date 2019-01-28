<template>
	<b-alert
		show
		variant="warning">
		<slot>
			Loading stuff for you …
		</slot>
		<v-icon name="spinner" scale="3" spin/>
	</b-alert>
</template>