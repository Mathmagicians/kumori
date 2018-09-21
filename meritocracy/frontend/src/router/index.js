import Vue from 'vue'
import Router from 'vue-router'
import About from '../views/About.vue'
import Components from '../views/TechComponentList.vue'
import Errors from '../views/Errors.vue'
import Exterminator from '../views/Exterminator.vue'
import Home from '../views/Home.vue'
import Services from '../views/Services.vue'
import Meritocracy from '../views/Meritocracy.vue'
import Database from '../views/Database.vue'

Vue.use(Router)



export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: Home
    }, {
      path: '/about',
      component: About
    }, {
      path: '/components',
      component: Components
    }, {
      path: '/exterminator',
      component: Exterminator
    }, {
      path: '/services',
      component: Services
    }, {
      path: '/meritocracy',
      component: Meritocracy
    }, 
    {
      path:'/components/search'
    },
    {
      path: '/components/:uid',
      component: Components
    }, {
      path: '/db',
      component: Database
    }, {
      path: '/404', 
      name: 'not-found', 
      component: Errors    
    }, {
      path: '*',
      redirect:  '/404'
    }
  ]
})
