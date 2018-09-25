import Vue from 'vue'
import Vuex from 'vuex'
import client from 'api-client'

Vue.use(Vuex)

export function createStore () {

  const LOGIN = "LOGIN";
  const LOGIN_SUCCESS = "LOGIN_SUCCESS";
  const LOGOUT = "LOGOUT";

  return new Vuex.Store({
    state: {
      security: {
        isLoggedIn: !!localStorage.getItem('token')
      },
      lifeCycle: {
        title: 'Tech Menu Life Cycle',
        items: [
          {
            name: 'experimental',
            type: 'buy'
          },
          {
            name: 'testing',
            type: 'buy'
          },
          {
            name: 'poc',
            type: 'buy'
          },
          {
            name: 'default',
            type: 'hold'
          },
          {
            name: 'limited',
            type: 'hold'
          },
          {
            name: 'deprecated',
            type: 'sell'
          },
          {
            name: 'dontuse',
            type: 'sell'
          },
          {
            name: 'undecided',
            type: 'maybe'
          },
          {
            name: 'wip',
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
      fuzzySearchResults: [{
     "uid": "2e3b-2e7a-b285-4b99-e0ec-5377-4b02-6ec3",
    "name": "#Slack",
    "status": "testing",
    "description": "Slack is a cloud-based set of proprietary team collaboration tools and services.",
    "comments": "",
    "tags": [ 
      "Delivery Services",
      "Development",
      "Design and Development",
      "Developer communication",
      "Development team instant messaging"
    ],
    "licenses": [
      "See license plans at Slack.com"
    ],
    "links": [],
    "usecases": [
      {
        "name": "Development team instant messaging",
        "description": "Developer commuication channel, for instant messaging, designed to improve a teams fusion with its Continuos Delivery pipeline.",
        "status": "testing",
        "scope": "Typical Taoists Inc"
      }
    ],
    "log": [{
        "date": "2018-01-01",
        "description": "Status changed",
        "status": "testing"
      },
      {
        "date": "2018-01-01",
        "description": "Added to #techmenu",
        "status": "experimental"
      }
    ]
  }],
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
      state.pending = true;
      },
      [LOGIN_SUCCESS] (state) {
        state.isLoggedIn = true;
        state.pending = false;
      },
      [LOGOUT](state) {
        state.isLoggedIn = false;
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
        return new Promise(resolve => {
          setTimeout(() => {
            localStorage.setItem("token", "JWT");
            commit(LOGIN_SUCCESS);
            resolve();
          }, 1000);
        });
      },
      logout({ commit }) {
        localStorage.removeItem("token");
        commit(LOGOUT);
      }
    },
    getters: {
      isLoggedIn: state => {
        return state.security.isLoggedIn;
      }
}
  })
}
