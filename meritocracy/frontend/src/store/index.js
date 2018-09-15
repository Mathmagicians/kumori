import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export function createStore () 
{
	return new Vuex.Store
	({
		state: 
		{
			lifeCycle: 
			{ 
				title: "Tech Menu Life Cycle", 
				items: [
					{name: "experimental", type: "buy"},
					{name: "testing", type: "buy"},
					{name: "poc", type: "buy"},
					{name: "default", type: "hold"},
					{name: "limited", type: "hold"},
					{name: "deprecated", type: "sell"},
					{name: "dontuse", type: "sell"},
					{name: "undecided", type: "maybe"},
					{name: "wip", type: "maybe"}
				]
			},
			techComponents: []
		},
		mutations: 
		{
			setTechComponents (state, techComponents) 
			{
      			state.techComponents = techComponents
    		}
		},
		actions: {
    		fetchPosts ({ commit }) 
    		{
      			return client
        		.fetchTechComponents()
        		.then(techComponents => commit('setTechComponentss', techComponents))
    		}
  		}
	})
}

