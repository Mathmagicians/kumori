<template>
	<div id="app">
		<header>
			<router-link to="/">Meritocracy</router-link>
		</header>
		<b-nav>
			<b-nav-item>
				<router-link to="/">Meritocracy</router-link>
			</b-nav-item>
			<b-nav-item><router-link to="/components">Components</router-link></b-nav-item>
			<b-nav-item><router-link to="/services">Services</router-link></b-nav-item>
			<b-nav-item><router-link to="/exterminator">Exterminator</router-link></b-nav-item>
			<b-nav-item><router-link to="/about">About</router-link></b-nav-item>
		</b-nav>
		<router-view/>
	</div>
</template>

<script>
	export default {
		name: 'App'
	}
</script>
