import Vue from "vue";
import Router from "vue-router";
import store from "./store/store";

Vue.use(Router);

const router = new Router({
  mode: "history",
  routes: [
    {
      path: "/",
      component: () => import("./views/Home.vue")
    },
    {
      path: "/about",
      component: () => import("./views/About.vue")
    },
    {
      path: "/units",
      component: () => import("./views/Units.vue"),
      meta: { requiresAuth: true }
    },
    {
      path: "/projects",
      component: () => import("./views/Projects.vue"),
      meta: { requiresAuth: true }
    },
    {
      path: "/survey",
      component: () => import("./views/Survey.vue"),
      meta: { requiresAuth: true }
    },
    {
      path: "/forecast",
      component: () => import("./views/Forecast.vue"),
      meta: { requiresAuth: true }
    },
    {
      path: "/usecases",
      component: () => import("./views/Usecases.vue"),
      meta: { requiresAuth: true }
    },
    {
      path: "/taxonomy",
      component: () => import("./views/Taxonomy.vue"),
      meta: { requiresAuth: true }
    },
    {
      path: "/search",
      component: () => import("./views/Search.vue"),
      meta: { requiresAuth: true }
    },
    {
      path: "*",
      redirect: "/"
    }
  ]
});

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (store.getters.authenticated) {
      next()
    } else {
      next('/')
    }
  } else {
    next()
  }
})

export default router
