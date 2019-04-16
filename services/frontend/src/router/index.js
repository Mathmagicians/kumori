import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [{
    path: '/',
    component: () =>
      import('../views/Home.vue')
  }, {
    path: '/about',
    component: () =>
      import('../views/About.vue')
  }, {
    path: '/list',
    component: () =>
      import('../views/List.vue')
  }, {
    path: '/components',
    component: () =>
      import('../views/TechComponentList.vue'),
    name: 'component-list'
  }, {
    path: '/exterminator',
    component: () =>
      import('../views/Exterminator.vue')
  }, {
    path: '/projects',
    component: () =>
      import('../views/Projects.vue')
  }, {
    path: '/survey',
    component: () =>
      import('../views/Survey.vue')
  }, {
    path: '/meritocracy',
    component: () =>
      import('../views/Meritocracy.vue')
  }, {
    path: '/components/search',
    component: () =>
      import('../views/TechComponentList.vue')
  }, {
    path: '/components/:name',
    component: () =>
      import('../views/TechComponentList.vue'),
    name: 'component',
    props: true
  }, {
    path: '/components/:uid/edit',
    name: 'edit',
    component: () =>
      import('../components/TechComponentEditor.vue'),
    props: true
  }, {
    path: 'components/create',
    name: 'create',
    component: () =>
      import('../components/TechComponentEditor.vue'),
    props: true
  }, {
    path: '/db',
    component: () =>
      import('../views/Database.vue')
  }, {
    path: '/usecases',
    component: () =>
      import('../views/Usecases.vue')
  }, {
    path: '/404',
    name: 'not-found',
    component: () =>
      import('../views/Errors.vue'),
    props: {
      error: 404
    }
  }, {
    path: '/error',
    name: 'error',
    component: () =>
      import('../views/Errors.vue'),
    props: route => ({
      code: route.query.error,
      asset: route.query.asset
    })
  }, {
    path: '*',
    redirect: '/404'
  }]
})
