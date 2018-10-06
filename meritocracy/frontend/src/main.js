import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'
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
  clipboard,
  comment,
  exclamation,
  flag, 
  fire,
  heart,
  github,
  keyboard,
  link,
  lock,
  pen,
  play,
  plus,
  question,
  spinner,
  thumbs,
  times,
  toolbox,
  unlock,
  user
} from 'vue-awesome/icons'
import Icon from 'vue-awesome/components/Icon'
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import './app.css'
import VueFuse from 'vue-fuse'
 
Vue.use(BootstrapVue)
Vue.use(VueResource)
Vue.use(VueFuse)
Vue.component('v-icon', Icon)

Vue.config.productionTip = false

const store = createStore()

sync(store, router)

const app = new Vue({
  ...App,
  router,
  store
}).$mount('#app')
