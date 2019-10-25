import Vue from "vue";
import Vuex from "vuex";

import authentication from './modules/authentication'
import status from './modules/status'
import taxonomy from './modules/taxonomy'
import unit from './modules/unit'
import usecase from './modules/usecase'

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    authentication,
    status,
    taxonomy,
    unit,
    usecase
  },
  state: {
  },
  mutations: {
  },
  actions: {
  },
  getters: {
  }
});
