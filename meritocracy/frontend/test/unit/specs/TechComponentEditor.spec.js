import { shallowMount, mount, createLocalVue } from '@vue/test-utils'
import { expect } from 'chai'
import  TechComponentEditor  from '@/components/TechComponentEditor.vue'
import BootstrapVue from 'bootstrap-vue'
import Vuex from 'vuex'

const techModel= {
	uid: "",
	name: "",
	status: "",
	description: "",
	comments: [],
	tax: [],
	licenses: [],
	links: [],
	usecases: [],
	log: []
}

const localVue = createLocalVue()
//bootstrap global dependencies
localVue.use(BootstrapVue)
localVue.use(Vuex)


describe('TechComponentEditor.vue', () => {
	describe( 'url adressing', () => {
		it('enables edit mode when query parameter action is equal update /components/:uid?action=update'),
		it('enables create mode when query parameter action is equal create as in /components?action=create'),
		it('displays the same uid in the form and in the url /components/:uid?action=update')
	}),
	describe( 'API interaction', () => {
		it('calls the UPDATE API on update'),
		it('calls the CREATE API on create')
	}),
	describe('Form content and user interaction', ()=>{

		let getters
  		let store

  		beforeEach( ()=>{
  			getters = {
  				isEditOn: () => true,
  				lifeCycle: () => ({ 
        			title: 'mock',
        			items: [
						{
							name: 'experimental',
							type: 'buy'
						},
						{
							name: 'default',
							type: 'hold'
						}
			        ]
			 	}),
			     taxonomy: () => ({
				    name: "Mock Taxonomy",
				    levels:[
				      {
				        level: 1,
				        name: "Type"
				      }
				    ],
				    tags: [
						{
							level: 1,
							name: "Business Application Services",
							parent: null
						}
				     ]
			     })
  			}
  			store = new Vuex.Store({
      			getters
    		})
  		})

		it('is a vue component named TechComponentEditor', ()=>{
			const wrapper = shallowMount( TechComponentEditor, {store, localVue} )
			expect( wrapper.isVueInstance()).to.equal(true)
			expect( wrapper.name()).to.equal('techComponentEditor')
		})
		it('is initialized with data from property object on object update'),
		it( 'is has empty values on object create', () => {

		}),
		it( 'has an input field for uid that can not be edited', ()=>{
			const wrapper = shallowMount( TechComponentEditor, {store, localVue} )

		}),
		it( 'has editable formfields for all object elements except uid'),
		it('can display the taxonomy in dropdown boxes'),
		it( 'can add a usecase to the list of usecases')
	}),
 	describe('Security and access restriction', ()=>{
 		it('does not display editor when edit is not on', ()=>{

		}),
		it('does display the editor when edit is on', ()=>{

		}),
		it('has a router navigation guard that protects from unauthorized access')
	})
})