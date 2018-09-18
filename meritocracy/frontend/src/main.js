import Vue from 'vue'
import Vuex from 'vuex'
import App from './App.vue'
import {
  sync
} from 'vuex-router-sync'
import router from './router'
import {
  createStore
} from './store'
import BootstrapVue from 'bootstrap-vue'
// add he font awesome-icons you need in the application here
import {
  flag,
  thumbs,
  question,
  spinner,
  keyboard,
  fire,
  heart,
  comment,
  exclamation,
  times
} from 'vue-awesome/icons'
import Icon from 'vue-awesome/components/Icon'
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import './app.css'

Vue.use(BootstrapVue)

Vue.component('v-icon', Icon)

Vue.config.productionTip = false

const store = createStore()

sync(store, router)

const app = new Vue({
  ...App,
  router,
  store
}).$mount('#app')
