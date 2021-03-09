import Vue from "vue";
import VueRouter from "vue-router";
// import store from "../store";

import Games from "../views/Games.vue";
import UserLogout from "../views/UserLogout.vue";
import Usuario from "../views/Usuario.vue";
import Options from "../views/Options.vue";
import Game from "../views/Game.vue";
import Dashboard from "../views/Dashboard.vue";
import Ranking from "../views/Ranking.vue";
import Encyclopedia from '../views/Encyclopedia'

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "home",
    component: Games,
  },
  {
    path: "/logout",
    name: "logout",
    component: UserLogout,
  },
  {
    path: "/games",
    name: "games",
    component: Games,
  },
  {
    path: "/usuario",
    name: "usuario",
    component: Usuario,
  },
  {
    path: "/options",
    name: "options",
    component: Options,
  },
  {
    path: "/game/:id",
    name: "game",
    component: Game,
  },
  {
    path: "/dashboard",
    name: "dashboard",
    component: Dashboard,
  },
  {
    path: "/ranking",
    name: "ranking",
    component: Ranking,
  },
  {
    path: "/encyclopedia",
    name: "enciclopedia",
    component: Encyclopedia,
  },
];

const router = new VueRouter({
  routes,
});

/* router.beforeEach((to, from, next) => {
  //necessary logic to resolve the hook
  if (to.name !== "home" && to.name !== "usuario" && !store.getters.auth.status)
    next({ name: "usuario" });
  else next();
}); */

export default router;
