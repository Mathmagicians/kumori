import Vue from 'vue'
import Vuex from 'vuex'
import App from './App.vue'
import { sync } from 'vuex-router-sync'
import router from './router'
import { createStore } from './store'
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import './app.css'

Vue.use(BootstrapVue)

Vue.config.productionTip = false

const store = createStore()

sync(store, router)

const app = new Vue({
  ...App,
  router,
  store
}).$mount('#app')
