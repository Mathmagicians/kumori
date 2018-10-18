import { shallowMount, createLocalVue } from '@vue/test-utils'
import { expect } from 'chai'
import ListWithPagination from '@/components/ListWithPagination.vue'
import BootstrapVue from 'bootstrap-vue'
import Vuex from 'vuex'

const localVue = createLocalVue()
// bootstrap global dependencies
localVue.use(BootstrapVue)
localVue.use(Vuex)

const factory = (props) => shallowMount(ListWithPagination, {store, localVue, props})

describe('ListWithPagination.vue', () => {
	let getters
  	let store

	beforeEach(() => {
		getters = {
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
	 		})
	 	}
		store = new Vuex.Store({
			getters
		})
	})
	describe('Page calculations', () => {
		it('The number of pages is from 0 to total/pageSize +1'){
			const props = { listSize: 2, listTotal: 5, buttonPanelSize: 2}
			const wrapper = factory(props)
		},
		it('index2List of slot 0 on page 0 returns 0')
		it('There is a button for each page'),
		it('When I press button for page i, I am shown contents of page i'),
		it('The amount of visible page buttons is same as buttonPanelSize if number of pages > bps'),
		it('The amount of visible page buttons is same as number of pages if buttonPanelSize > #pagese')
		it('Left rewind button shows contents of page 0'),
		it('Right rewind button shows contents of last page'),
		it('Scroll left button disabled for page 0'),
		it('Scroll left button shows a new button for a lower number page'),
		it('Scroll right button disabled for last page'),
		it('Scroll left button shows a new button for a lower number page')
	}),
	describe('', () => {
		it('Components in slots correspond to active page'),
		it('Number of visible components in the list is the same as property size for regular page'),
		it('Length of list is shorter for last page, if page length does not divide total')
	})
})
