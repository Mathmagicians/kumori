<template>
<div id="app" >
  <b-navbar type="dark" variant="dark" class="navbar navbar-expand-md">
    <b-navbar-brand to="/" class="d-inline-block align-top" alt="techmenu logo">
      <b-img src="./assets/techmenu.svg" width="64" height="64" class="m-1" />
      #techmenu
    </b-navbar-brand>

    <b-navbar-nav>
      <b-nav-item to="/components">
        <b-img rounded="circle" src="./assets/components.svg" class="image-overlay" />
        Components
      </b-nav-item>
      <b-nav-item to="/services">
        <b-img rounded="circle" src="./assets/service.svg" class="image-overlay" />
        Services
      </b-nav-item>
      <b-nav-item to="/exterminator">
        <b-img rounded="circle" src="./assets/exterminator.svg" class="image-overlay" />
        Exterminator
      </b-nav-item>
      <b-nav-item to="/meritocracy">
        <b-img rounded="circle" src="./assets/meritocracy.svg" class="image-overlay" />
        Meritocracy
      </b-nav-item>
      <b-nav-item to="/about">
        <b-img rounded="circle" src="./assets/about.svg" class="image-overlay" />
        About
      </b-nav-item>
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
       <router-view />
    </transition>
  </b-container>

  <footer>
    Copyright 2018 by Mathmagicians. Powered by Kumori.
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
</style>
