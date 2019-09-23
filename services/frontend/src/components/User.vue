<template>
  <div>
    <b-navbar-nav class="ml-auto">
      <b-nav-item-dropdown right v-if="authenticated">
        <template slot="button-content">
          <v-icon name="user" color="green" />
        </template>
        <b-dropdown-item href="#">Profile</b-dropdown-item>
        <b-dropdown-item v-on:click="logout">Sign out</b-dropdown-item>
      </b-nav-item-dropdown>
      <b-nav-item-dropdown right v-if="!authenticated">
        <template slot="button-content">
          <v-icon name="user" />
        </template>
        <b-dropdown-item v-b-modal.login_modal>Sign in</b-dropdown-item>
      </b-nav-item-dropdown>
      <b-nav-item @click="read" v-if="!readonly" title="Exit edit mode">
        <v-icon name="unlock" color="green" />
      </b-nav-item>
      <b-nav-item
        @click="crud"
        v-if="readonly && authenticated"
        title="Enter edit mode"
      >
        <v-icon name="lock" />
      </b-nav-item>
    </b-navbar-nav>

    <b-modal ref="login_modal" id="login_modal" title="Kumori Login">
      <b-form-group
        id="login_username_group"
        label="Username:"
        label-for="login_username"
      >
        <b-form-input
          id="login_username"
          type="text"
          v-model="username"
          required
          placeholder="Username"
        >
        </b-form-input>
      </b-form-group>
      <b-form-group
        id="login_passoword_group"
        label="Password:"
        label-for="login_password"
      >
        <b-form-input
          id="login_password"
          type="password"
          v-model="password"
          v-on:keydown.native.enter="login"
          required
          placeholder="Password"
        >
        </b-form-input>
      </b-form-group>
      <div slot="modal-footer" class="w-100">
        <b-button class="float-right" variant="primary" @click="login">
          Login
        </b-button>
        <b-button class="float-right" variant="secondary" @click="auth0">
          Auth0 Login
        </b-button>
      </div>
    </b-modal>
  </div>
</template>

<script>
import {
  mapGetters,
  mapActions
} from 'vuex'
import AuthService from "../api/AuthService.js";
import Icon from "vue-awesome/components/Icon";
import "vue-awesome/icons/unlock";
import "vue-awesome/icons/lock";
import "vue-awesome/icons/user";

const auth = new AuthService();
export default {
  name: "Login",
  components: {
    "v-icon": Icon
  },
  data() {
    return {
      username: "",
      password: ""
    };
  },
  computed: {
    ...mapGetters([
      'authenticated',
      'readonly'
    ])
  },
  methods: {
    ...mapActions([
      'logout',
      'crud',
      'read'
    ]),
    login: function() {
      //TODO move all logic to store
      if (this.username !== "" && this.password !== "") {
        this.$store.dispatch("login", {
          username: this.username,
          password: this.password
        });
      }
      this.$refs.login_modal.hide();
    },
    //TODO move to store
    auth0() {
      auth.login();
    }
  }
};
</script>

<style scoped></style>
