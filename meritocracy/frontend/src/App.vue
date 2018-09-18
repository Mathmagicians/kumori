<template>
<div id="app">
  <b-navbar type="dark" variant="dark" class="navbar navbar-expand-md">
    <b-navbar-brand to="/" class="d-inline-block align-top" alt="techmenu logo">
      <b-img src="./assets/techmenu.svg" width="64" height="64" class="m-1" />
      #techmenu
    </b-navbar-brand>

    <b-navbar-nav>
      <b-nav-item to="/components">
        <b-img rounded="circle" blank blank-color="white" src="./assets/techmenu.svg" class="image-overlay" />
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
        <b-img rounded="circle" src="./assets/community.svg" class="image-overlay" />
        Meritocracy
      </b-nav-item>
      <b-nav-item to="/about">
        <b-img rounded="circle" blank blank-color="white" class="image-overlay" />
        About
      </b-nav-item>
    </b-navbar-nav>
  </b-navbar>
  
  <b-container fluid>
    <transition name="fade" mode="out-in">
       <router-view class="m-1" />
    </transition>
  </b-container>
  
  <footer>
    Copyright 2018 by Mathmagicians. Powered by Kumori.
  </footer>

</div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>

</style>
