<template>
<b-navbar type="dark" variant="dark" class="navbar navbar-expand-md">
  <b-navbar-brand to="/" class="d-inline-block align-top" alt="techmenu logo">
    <b-img src="../assets/kumori_white.svg" width="32" height="32" />
    Kumori
  </b-navbar-brand>

  <b-navbar-nav>
    <b-nav-item to="/components">
      <v-icon name="boxes" /> Components</b-nav-item>
    <b-nav-item to="/services">
      <v-icon name="cubes" /> Services</b-nav-item>
    <b-nav-item to="/exterminator">
      <v-icon name="book-dead" /> Exterminator</b-nav-item>
    <b-nav-item to="/meritocracy">
      <v-icon name="comments" /> Meritocracy</b-nav-item>
    <b-nav-item to="/about">
      <v-icon name="paw" /> About</b-nav-item>
  </b-navbar-nav>

  <b-navbar-nav class="ml-auto">
    <b-nav-item v-if="isEditOn">
      <b-button @click="editOff" class="btn-round" variant="light">
        <v-icon name="unlock" color="green" />
      </b-button>
      Editing
    </b-nav-item>
    <b-nav-item v-else-if="isLoggedIn">
      <b-button @click="editOn" class="btn-round" variant="light">
        <v-icon name="lock" color="orange" />
      </b-button>
      Edit
    </b-nav-item>
    <b-nav-item-dropdown v-if="isLoggedIn" right>
      <template slot="button-content">
        <b-button class="btn-round" variant="light">
          <v-icon name="user" color="green"></v-icon>
        </b-button>
        User
      </template>
      <b-dropdown-item href="#">Profile</b-dropdown-item>
      <b-dropdown-item @click="logout">
        Sign Out
      </b-dropdown-item>
    </b-nav-item-dropdown>
    <b-nav-item-dropdown v-else right>
      <template slot="button-content">
        <b-button class="btn-round" variant="light">
          <v-icon name="user" color="green"></v-icon>
        </b-button>
        Sign in!
      </template>
      <b-dropdown-item to="/login">Sign in</b-dropdown-item>
    </b-nav-item-dropdown>
  </b-navbar-nav>
</b-navbar>
</template>

<script>
import Icon from 'vue-awesome/components/Icon'
import 'vue-awesome/icons/boxes'
import 'vue-awesome/icons/cubes'
import 'vue-awesome/icons/book-dead'
import 'vue-awesome/icons/comments'
import 'vue-awesome/icons/paw'
import 'vue-awesome/icons/unlock'
import 'vue-awesome/icons/lock'
import 'vue-awesome/icons/user'
export default {
  name: 'navbar',
  components: {
    'v-icon': Icon
  },
  props: [],
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
      this.$store.dispatch('logout');
    },
    editOn() {
      this.$store.dispatch('editOn');
    },
    editOff() {
      this.$store.dispatch('editOff');
    }
  }
}
</script>

<style scoped>
.btn-round {
  border-radius: 50px;
}

.navbar-dark .navbar-nav .active>.nav-link,
.navbar-dark .navbar-nav .nav-link.active,
.navbar-dark .navbar-nav .nav-link.show,
.navbar-dark .navbar-nav .show>.nav-link {
  border-bottom: 1px solid green;
}
</style>
