import Vue from "vue";
import Vuex from "vuex";

import memoria from "./modules/memoria";
import trivia from "./modules/trivia";
import tetris from "./modules/tetris";

import { getUserData } from "../utils/services";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    sesion: {
      status: false,
      name: null,
    },
    reportDialog: false,
    warningDialog: false,
    changesDialog: false,
  },
  mutations: {
    setUserData(state, payload) {
      state.sesion.status = true;
      state.sesion.name = payload;
    },
    logOut(state) {
      state.sesion = {
        status: false,
        name: null,
      };
    },
    changeReport(state) {
      state.reportDialog = !state.reportDialog;
    },
    changeWarning(state) {
      state.warningDialog = !state.warningDialog;
    },
    changeChanges(state) {
      state.changesDialog = !state.changesDialog;
    },
  },
  getters: {
    auth(state) {
      return state.sesion;
    },
  },
  actions: {
    validarSesion: function({ commit }) {
      getUserData()
        .then((response) => {
          commit("setUserData", response.data.nombre);
        })
        .catch((e) => e);
    },
  },
  modules: {
    tetris,
    trivia,
    memoria,
  },
});
