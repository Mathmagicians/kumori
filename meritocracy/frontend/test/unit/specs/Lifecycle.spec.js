import { mount, createLocalVue } from '@vue/test-utils'
import { expect } from 'chai'
import LifeCycle from '@/components/LifeCycle.vue'
import BootstrapVue from 'bootstrap-vue'
import Vuex from 'vuex'

const localVue = createLocalVue()
// bootstrap global dependencies
localVue.use(BootstrapVue)
localVue.use(Vuex)
const factory = (store, propsData) =>  mount(LifeCycle, {localVue, store, propsData})

describe('ListWithPagination.vue', () => {
	
	const getters = {
			lifeCycle: () => [
				{
					name: 'experimental',
					type: 'buy'
				},
				{
					name: 'default',
					type: 'hold'
				}
	        ]
	 	}
	const store = new Vuex.Store({
			getters
	})

	const wrapper = factory( store, {status: 'experimental'})
	const instance = wrapper.vm
	

	it('The property status is displayed as text', ()=>{
		let buttonText = wrapper.find('button').text() 
		expect(buttonText).to.be.equal('experimental'.toUpperCase())
			
			
	}),
	it('Button color corresponds to phase of status property', ()=>{

	}),
	it('Unknown property status is displayed as MISSING', ()=>{

	})
})
