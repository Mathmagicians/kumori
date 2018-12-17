<template>
<div id="app" >
  <b-navbar type="dark" variant="dark" class="navbar navbar-expand-md">
    <b-navbar-brand to="/" class="d-inline-block align-top" alt="techmenu logo">
      <b-img src="./assets/logo.svg" width="32" height="32" />
      Meritocracy
    </b-navbar-brand>

    <b-navbar-nav>
      <b-nav-item to="/components"><v-icon name="boxes"/> Components</b-nav-item>
      <b-nav-item to="/services"><v-icon name="cubes"/> Services</b-nav-item>
      <b-nav-item to="/exterminator"><v-icon name="book-dead"/> Exterminator</b-nav-item>
      <b-nav-item to="/meritocracy"><v-icon name="comments"/> Meritocracy</b-nav-item>
      <b-nav-item to="/about"><v-icon name="paw"/> About</b-nav-item>
    </b-navbar-nav>

    <b-navbar-nav class="ml-auto">
      <b-nav-item
         v-if="isEditOn">
         <b-button
          @click="editOff"
          class="btn-round"
          variant="light">
            <v-icon name="unlock" color="green"/>
          </b-button>
          Editing
      </b-nav-item>
       <b-nav-item
        v-else-if="isLoggedIn">
         <b-button
          @click="editOn"
          class="btn-round"
          variant="light">
            <v-icon name="lock" color="orange"/>
          </b-button>
          Edit
      </b-nav-item>
      <b-nav-item-dropdown v-if="isLoggedIn"
        right>
        <template slot="button-content">
          <b-button class="btn-round" variant="light">
            <v-icon name="user" color="green" ></v-icon>
          </b-button>
          User
        </template>
        <b-dropdown-item href="#">Profile</b-dropdown-item>
        <b-dropdown-item
          @click="logout"
          >
          Sign Out
        </b-dropdown-item>
      </b-nav-item-dropdown>
      <b-nav-item-dropdown
        v-else
        right>
        <template slot="button-content">
          <b-button class="btn-round" variant="light">
            <v-icon name="user" color="green" ></v-icon>
          </b-button>
          Sign in!
        </template>
        <b-dropdown-item to="/login">Sign in</b-dropdown-item>
      </b-nav-item-dropdown>
    </b-navbar-nav>
  </b-navbar>

  <b-container fluid>
    <transition name="fade" mode="out-in">
      <b-alert v-if="detectIE() != false" variant="danger" show>Old versions of Internet Explorer is not supported at this time. Please use Chrome or Firefox instead.</b-alert>
      <router-view v-if="detectIE() == false" />
    </transition>
  </b-container>

  <footer class="footer bg-dark">
    <div class="container text-center">
        <span class="text-muted" title="Copyright 2018 by Mathmagicians.">Powered by Kumori.</span>
      </div>
  </footer>

</div>
</template>

<script>

  export default {
    name: 'App',
    computed: {
      isLoggedIn() {
        return this.$store.getters.isLoggedIn;
      },
      isEditOn() {
        return this.$store.getters.isEditOn;
      }
    },
    methods: {
      logout() {
        console.log("logging user out");
        this.$store.dispatch('logout');
      },
      editOn(){
        this.$store.dispatch('editOn');
      },
      editOff(){
        this.$store.dispatch('editOff');
      },
      detectIE() {
				let ua = window.navigator.userAgent;
				let msie = ua.indexOf('MSIE ');
				if (msie > 0) {
				  // IE 10 or older => return version number
				  return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
				}

				let trident = ua.indexOf('Trident/');
				if (trident > 0) {
				  // IE 11 => return version number
				  let rv = ua.indexOf('rv:');
				  return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
				}

				let edge = ua.indexOf('Edge/');
				if (edge > 0) {
				  // Edge (IE 12+) => return version number
				  return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
				}
				return false;
			}
    }
  }
</script>

<style>
.image-overlay {
  width: 48px;
  height: 48px;
  background-color: #ffffff;
  border-style: solid;
  border-width: medium;
  border-color: #aaaaaa;
  opacity: 1;
}

.btn-round {
  border-radius: 50px;
}

#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

html {
  position: relative;
  min-height: 100%;
}

body {
  margin-bottom: 65px; /* Margin bottom by footer height */
}
.footer {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 50px; /* Set the fixed height of the footer here */
  line-height: 50px; /* Vertically center the text there */
}

.container {
  width: auto;
  max-width: 680px;
  padding: 0 15px;
}

.navbar-dark .navbar-nav .active > .nav-link, .navbar-dark .navbar-nav .nav-link.active, .navbar-dark .navbar-nav .nav-link.show, .navbar-dark .navbar-nav .show > .nav-link {
  border-bottom: 1px solid green;
}
</style>
