import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

export default new Router({
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
      path: "/list",
      component: () => import("./views/List.vue")
    },

    {
      path: "/projects",
      component: () => import("./views/Projects.vue")
    },
    {
      path: "/survey",
      component: () => import("./views/Survey.vue")
    },
    {
      path: "/usecases",
      component: () => import("./views/Usecases.vue")
    },
    {
      path: "/404",
      name: "not-found",
      component: () => import("./views/Errors.vue"),
      props: {
        error: 404
      }
    },
    {
      path: "/error",
      name: "error",
      component: () => import("./views/Errors.vue"),
      props: route => ({
        code: route.query.error,
        asset: route.query.asset
      })
    },
    {
      path: "*",
      redirect: "/404"
    }
  ]
});
