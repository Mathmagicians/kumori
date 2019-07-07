<template>
  <b-navbar toggleable="md" type="dark" variant="dark">
    <b-navbar-toggle target="nav_collapse"></b-navbar-toggle>
    <b-navbar-brand to="/">
      <b-img :src="require('../assets/kumori_white.svg')" width="32" height="32"/>Kumori
    </b-navbar-brand>
    <b-collapse is-nav id="nav_collapse">
      <b-navbar-nav>
        <b-nav-item-dropdown v-if="authenticated" right>
          <template slot="button-content">
            <v-icon name="boxes"/>Architecture
          </template>
          <b-dropdown-item to="/units">
            <v-icon name="boxes"/>Components
          </b-dropdown-item>
          <b-dropdown-item to="/usecases">
            <v-icon name="toolbox"/>Usecases
          </b-dropdown-item>
          <b-dropdown-item to="/projects">
            <v-icon name="cubes"/>Projects
          </b-dropdown-item>
        </b-nav-item-dropdown>
        <b-nav-item to="/forecast" v-if="authenticated">
          <v-icon name="cloud-sun"/>Forecast
        </b-nav-item>
        <b-nav-item to="/about">
          <v-icon name="paw"/>About
        </b-nav-item>
      </b-navbar-nav>
      <!-- Right aligned nav items -->
      <b-navbar-nav class="ml-auto">
        <b-nav-form>
          <b-input-group>
            <b-form-input
              size="sm"
              type="text"
              placeholder="Search..."
              v-on:keydown.native="onEnter"
            ></b-form-input>
            <b-input-group-append>
              <b-btn size="sm" to="/search">
                <v-icon name="search"></v-icon>
              </b-btn>
            </b-input-group-append>
          </b-input-group>
        </b-nav-form>
      </b-navbar-nav>
      <user/>
    </b-collapse>
  </b-navbar>
</template>

<script>
import { mapGetters } from "vuex";
import Icon from "vue-awesome/components/Icon";
import User from "../components/User.vue";
import "vue-awesome/icons/boxes";
import "vue-awesome/icons/cubes";
import "vue-awesome/icons/cloud-sun";
import "vue-awesome/icons/paw";
import "vue-awesome/icons/unlock";
import "vue-awesome/icons/lock";
import "vue-awesome/icons/user";
import "vue-awesome/icons/search";
import "vue-awesome/icons/toolbox";
export default {
  name: "navigation",
  components: {
    "v-icon": Icon,
    user: User
  },
  computed: {
    ...mapGetters(["authenticated"])
  },
  methods: {
    onEnter: function(event) {
      if (event.which === 13) {
        this.$router.push({
          path: "/components"
        });
      }
    }
  }
};
</script>

<style scoped>
.navbar-dark .navbar-nav .active > .nav-link,
.navbar-dark .navbar-nav .nav-link.active,
.navbar-dark .navbar-nav .nav-link.show,
.navbar-dark .navbar-nav .show > .nav-link {
  border-bottom: 1px solid green;
}
</style>
