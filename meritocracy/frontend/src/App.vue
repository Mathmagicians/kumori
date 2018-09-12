<template>
	<div id="app">
		<b-navbar type="light" variant="faded">
			<b-navbar-brand to="/">
				<img src="./assets/techmenu.svg">
			</b-navbar-brand>
			<b-navbar-nav>
				<b-nav-item to="/">Meritocracy</b-nav-item>
				<b-nav-item to="/components">Components</b-nav-item>
				<b-nav-item to="/services">Services</b-nav-item>
				<b-nav-item to="/exterminator">Exterminator</b-nav-item>
				<b-nav-item to="/about">About</b-nav-item>
			</b-navbar-nav>
		</b-navbar>
		<router-view/>
	</div>
</template>

<script>
	export default {
		name: 'App'
	}
</script>
