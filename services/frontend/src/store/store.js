import Vue from "vue";
import Vuex from "vuex";
import authentication from '@/store/modules/authentication'
import status from '@/store/modules/status'
import phase from '@/store/modules/phase'
import taxonomy from '@/store/modules/taxonomy'
import unit from '@/store/modules/unit'
import usecase from '@/store/modules/usecase'

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    authentication,
    status,
    phase,
    taxonomy,
    unit,
    usecase
  },
  state: {},
  mutations: {},
  actions: {},
  getters: {
    api: state => state.api
  }
});
