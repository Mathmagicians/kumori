<template>
	<div id="app">
		<b-navbar type="dark" variant="dark" class="navbar navbar-expand-md fixed-top">
			<b-navbar-brand to="/" class="d-inline-block align-top" alt="techmenu logo">
				<b-img  src="./assets/techmenu.svg" width="64" height="65" class="m-1"/>
				<p><small>POWERED BY Meritocracy</small></p>
			</b-navbar-brand>

			<b-navbar-nav>
				<b-nav-item to="/">
					<b-img rounded="circle" src="./assets/techmenu.svg"  class="image-overlay"/>
					Meritocracy
				</b-nav-item>
				<b-nav-item to="/components">
					<b-img rounded="circle" blank blank-color="white" src="./assets/techmenu.svg"  class="image-overlay"/>
					Components
				</b-nav-item>
				<b-nav-item to="/services">
					<b-img rounded="circle" blank blank-color="white" src="./assets/techmenu.svg"  class="image-overlay"/>
					Services
				</b-nav-item>
				<b-nav-item to="/exterminator"> 
					<b-img rounded="circle"   src="./assets/exterminator.svg"  class="image-overlay"/>
					Exterminator
				 </b-nav-item>
				<b-nav-item to="/about">
					<b-img rounded="circle" blank blank-color="white" src="./assets/techmenu.svg"  class="image-overlay"/>
					About
				</b-nav-item>
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

<style>
	.image-overlay {
  width: 48px;
  height: 48px;
  background-color: #ffffff;
  opacity: 1;
}
</style>
