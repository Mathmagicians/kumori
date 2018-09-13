import Vue from 'vue'
import Router from 'vue-router'
import About from '../views/About.vue'
import Components from '../views/components.vue'
import Errors from '../views/Errors.vue'
import Exterminator from '../views/Exterminator.vue'
import Home from '../views/Home.vue'
import Services from '../views/Services.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [{
      path: '/',
      component: Home
    },
    {
      path: '/about',
      component: About
    },
    {
      path: '/components',
      component: Components
    },
    {
      path: '/exterminator',
      component: Exterminator
    },
    {
      path: '/services',
      component: Services
    },
    // Dynamic routes
    {
      path: '/views/:name',
      component: Components
    }
  ]
})
