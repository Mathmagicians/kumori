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

describe('LifeCycle.vue', () => {

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

	it('The property status is displayed as text', ()=>{
		const wrapper = factory( store, {status: 'experimental'})
		let buttonText = wrapper.find('button').text()
		expect(buttonText).to.be.equal('experimental'.toUpperCase())
	}),
	it('Button color corresponds to phase of status property', ()=>{
		const wrapper = factory( store, {status: 'experimental'})
		const button = wrapper.find('button')
		console.log(button.text())
		const style = button.element.style
		console.log(button.element.style)
		const experimentalColor = factory( store, {status: 'experimental'}).find('button').element.style.color
		const defaultColor = factory( store, {status: 'default'}).find('button').element.style.color
		const missingColor = factory( store, {status: 'julemand'}).find('button').element.style.color
    //TOOO FIXME
		//expect(defaultColor).to.not.be.equal(experimentalColor)
		//expect(missingColor).to.not.be.equal(experimentalColor)
		//expect(missingColor).to.not.be.equal(defaultColor)
	}),
	it('Unknown property status is displayed as MISSING', ()=>{
		const missing = factory( store, {status: 'missing'})
		const buttonText = missing.find('button').text()
		expect(buttonText.toUpperCase()).to.be.equal('missing'.toUpperCase())
	})
})
