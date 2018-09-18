import Vue from 'vue'
import Vuex from 'vuex'
import client from 'api-client'

Vue.use(Vuex)

export function createStore () {
  return new Vuex.Store({
    state: {
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
      meritocracy: [],
      services: []
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
      }
    },
    actions: {
      fetchTechComponents ({
        commit
      }) {
        return client
          .fetchTechComponents()
          .then(techComponents => commit('setTechComponents', techComponents))
      },
      fetchMeritocracy ({
        commit
      }) {
        return client
          .fetchMeritocracy()
          .then(meritocracy => commit('setMeritocracy', meritocracy))
      },
      fetchServices ({
        commit
      }) {
        return client
          .fetchServices()
          .then(services => commit('setServices', services))
      }
    }
  })
}
