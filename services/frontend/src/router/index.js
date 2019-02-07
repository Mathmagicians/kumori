import Vue from 'vue'
import Router from 'vue-router'
import About from '../views/About.vue'
import TechComponentsList from '../views/TechComponentList.vue'
import Errors from '../views/Errors.vue'
import Exterminator from '../views/Exterminator.vue'
import Home from '../views/Home.vue'
import Services from '../views/Services.vue'
import Meritocracy from '../views/Meritocracy.vue'
import Database from '../views/Database.vue'
import TechComponentEditor from '../components/TechComponentEditor.vue'
import Usecases from '../components/Usecases.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [{
      path: '/',
      component: Home
    }, {
      path: '/about',
      component: About
    }, {
      path: '/components',
      component: TechComponentsList,
      name: 'component-list'
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
      path: '/components/search',
      component: TechComponentsList
    },
    {
      path: '/components/:name',
      component: TechComponentsList,
      name: 'component',
      props: true
    },
    {
      path: '/components/:uid/edit',
      name: 'edit',
      component: TechComponentEditor,
      props: true
    },
    {
      path: 'components/create',
      name: 'create',
      component: TechComponentEditor,
      props: true
    },
    {
      path: '/db',
      component: Database
    },
    {
      path: '/usecases',
      component: Usecases
    },
    {
      path: '/404',
      name: 'not-found',
      component: Errors,
      props: {
        error: 404
      }
    },
    {
      path: '/error',
      name: 'error',
      component: Errors,
      props: route => ({
        code: route.query.error,
        asset: route.query.asset
      })
    },
    {
      path: '*',
      redirect: '/404'
    }
  ]
})
