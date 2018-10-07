import Vue from 'vue'
import Vuex from 'vuex'
import client from 'api-client'

Vue.use(Vuex)

export function createStore () {

  const LOGIN = "LOGIN";
  const LOGIN_SUCCESS = "LOGIN_SUCCESS";
  const LOGOUT = "LOGOUT";
  const EDIT_ON = "EDIT_ON";
  const EDIT_OFF = "EDIT_OFF";
  const CREATE_TECH_COMPONENT = "CREATE_TECH_COMPONENT";
  const EDIT_TECH_COMPONENT = "EDIT_TECH_COMPONENT";

  return new Vuex.Store({
    state: {
      security: {
        isLoggedIn: !!localStorage.getItem('token'),
        pending: false,
        isEditOn: false
      },
      lifeCycle: {
        title: 'Tech Menu Life Cycle',
        items: [
          {
            name: 'Experimental',
            type: 'buy'
          },
          {
            name: 'Testing',
            type: 'buy'
          },
          {
            name: 'Poc',
            type: 'buy'
          },
          {
            name: 'Default',
            type: 'hold'
          },
          {
            name: 'Limited',
            type: 'hold'
          },
          {
            name: 'Deprecated',
            type: 'sell'
          },
          {
            //dontuse
            name: 'Dont',
            type: 'sell'
          },
          {
            //undecided
            name: 'Undecided',
            type: 'maybe'
          },
          {
            name: 'WIP',
            type: 'maybe'
          }
        ]
      },
      phaseImages: {
		'buy': require('../assets/buy.svg'),
		'hold': require('../assets/service.svg'), 
		'sell': require('../assets/exterminator.svg'), 
		'maybe': require('../assets/community.svg')
	  },
      techComponents: [],
      meritocracy: [],
      services: [],
      taxonomy: []
    },
    mutations: {
      setTechComponents (state, techComponents) {
        state.techComponents = techComponents
      },
      setMeritocracy (state, meritocracy) {
        state.meritocracy = meritocracy
      },
      setServices (state, services) {
        state.services = services
      },
      setTaxonomy (state, taxonomy) {
        state.taxonomy = taxonomy
      },
      [LOGIN] (state) {
      state.security.pending = true;
      },
      [LOGIN_SUCCESS] (state) {
        state.security.isLoggedIn = true;
        state.security.pending = false;
      },
      [LOGOUT](state) {
        state.security.isLoggedIn = false;
      },
      [EDIT_OFF](state) {
        state.security.isEditOn = false;
      },
      [EDIT_ON](state) {
        state.security.isEditOn = true; 
      },
      [CREATE_TECH_COMPONENT](state, tech) {
        state.techComponents.push(tech)
      },
      [EDIT_TECH_COMPONENT]( state, tech){
        let index = state.techComponents.findIndex( t => t.uid === tech.uid )
        state.techComponents.splice( index, 1, tech)
      }
    },
    actions: {
      fetchTechComponents ({ commit}) {
          return client
            .fetchTechComponents()
            .then(techComponents => commit('setTechComponents', techComponents))
      },
      fetchMeritocracy ({ commit }) {
          return client
            .fetchMeritocracy()
            .then(meritocracy => commit('setMeritocracy', meritocracy))
      },
      fetchServices ({ commit }) {
        return client
          .fetchServices()
          .then(services => commit('setServices', services))
      },
      fetchTaxonomy ({ commit }) {
        return client
          .fetchTaxonomy()
          .then(taxonomy => commit('setTaxonomy', taxonomy))
      },
      login({ commit }, creds) {
        commit(LOGIN); // show spinner
        return client
          .login(creds)
          .then( token =>  {
            localStorage.setItem("token", token)
            console.log(token)
            commit(LOGIN_SUCCESS)
          })
      },
      logout({ commit }) {
        localStorage.removeItem("token");
        commit(LOGOUT);
      },
      editOn({commit}){
        commit(EDIT_ON);
      },
      editOff({commit}){
        commit(EDIT_OFF);
      },
      createTechComponent({commit}, techComponent ){
        return client
          .createTechComponent( techComponent)
          .then( tc => commit( CREATE_TECH_COMPONENT, tc));

      },
      editTechComponent({commit}, techComponent ){
        return client
          .editTechComponent( techComponent )
          .then( tc => commit ( EDIT_TECH_COMPONENT, tc));
      }
    },
    getters: {
      isLoggedIn: state => state.security.isLoggedIn,
      isEditOn: state =>  state.security.isEditOn,
      lifeCycle: state =>  state.lifeCycle,
      taxonomy: state => state.taxonomy, 
      tech: state => state.techComponents
    }
  })
}
