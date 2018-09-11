<template>
	<div id="app">
		<b-nav-bar type="light" variant="faded" fixed="top">
			<b-navbar-brand to="/">
				<img src="./assets/techmenu.svg">
			</b-navbar-brand>
			<b-navbar-nav>
				<b-nav-item><router-link to="/">Meritocracy</router-link></b-nav-item>
				<b-nav-item><router-link to="/components">Components</router-link></b-nav-item>
				<b-nav-item><router-link to="/services">Services</router-link></b-nav-item>
				<b-nav-item><router-link to="/exterminator">Exterminator</router-link></b-nav-item>
				<b-nav-item><router-link to="/about">About</router-link></b-nav-item>
			</b-navbar-nav>
		</b-nav-bar>
		<router-view/>
	</div>
</template>

<script>
	export default {
		name: 'App'
	}
</script>
