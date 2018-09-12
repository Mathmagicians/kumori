import Vue from 'vue'
import Router from 'vue-router'
import About from '../components/About.vue'
import Components from '../components/Components.vue'
import Errors from '../components/Errors.vue'
import Exterminator from '../components/Exterminator.vue'
import Home from '../components/Home.vue'
import Services from '../components/Services.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {path: '/', component: Home},
    {path: '/about', component: About},
    {path: '/components', component: Components},
    {path: '/exterminator', component: Exterminator},
    {path: '/services', component: Services},
    //dynamic routes
     { path: '/components/:name', component: Components }
  ]
})
