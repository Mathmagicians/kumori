import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export function createStore () {
	return new Vuex.Store({
		state: {
			lifeCycle: 
			{ title: "Tech Menu Life Cycle", 
				items: [
					{name: "Undecided", type: "maybe"},
					{name: "WIP", type: "maybe"},
					{name: "Experimental", type: "buy"},
					{name: "Testing", type: "buy"},
					{name: "POC", type: "maybe"},
					{name: "Default", type: "hold"},
					{name: "Limited", type: "hold"},
					{name: "Deprecated", type: "sell"},
					{name: "Don't use", type: "sell"}
				]
			}
		}
	})
}

