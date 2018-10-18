import { mount, createLocalVue } from '@vue/test-utils'
import { expect } from 'chai'
import ListWithPagination from '@/components/ListWithPagination.vue'
import BootstrapVue from 'bootstrap-vue'
import Vuex from 'vuex'

const localVue = createLocalVue()
// bootstrap global dependencies
localVue.use(BootstrapVue)
const factory = (propsData) =>  mount(ListWithPagination, {localVue, propsData})

describe('ListWithPagination.vue', () => {
	const propsData = { listSize: 2, listTotal: 7, buttonPanelSize: 2}
	const wrapper = factory(propsData)
	const instance = wrapper.vm
		
	describe('Component page state and calculations', () => {		
		it('The number of pages is the list total divided by pageSize, and rounded up', ()=>{
			expect(instance.numOfPages).to.be.equal(4)
		}),
		it('index2ListOrdinal converst the slot index (1..n) on the active page to the ordinal number in list (0..total)', ()=>{
			wrapper.setData({activePageIndex: 0})
			expect(instance.index2ListOrdinal(1)).to.be.equal(0)
			expect(instance.index2ListOrdinal(2)).to.be.equal(1)
			wrapper.setData({activePageIndex: 1})
			expect(instance.index2ListOrdinal(1)).to.be.equal(2)
			wrapper.setData({activePageIndex: 3})
			expect(instance.index2ListOrdinal(1)).to.be.equal(6)
		}),
		it('A slot is not visible on the page, if it is the last page and the slot points to a higher element than the list (0..total)', () => {
			wrapper.setData({activePageIndex: 3})
			expect(instance.isOnPage(2)).to.be.false
		}),
		it('Shows method returns to and from values, that are indexe from [1..total]', () => {
			let shows = instance.shows(0,2,7)
			expect(shows.from).to.be.equal(1)
			expect(shows.to).to.be.equal(2)
			shows = instance.shows(1,2,7)
			expect(shows.from).to.be.equal(3)
			expect(shows.to).to.be.equal(4)
			shows = instance.shows(3,2,7)
			expect(shows.from).to.be.equal(7)
			expect(shows.to).to.be.equal(7)
		}),
		it('scrollToPage does not scroll to page out of bounds', () => {
			instance.scrollToPage(1)
			expect(instance.activePageIndex).to.be.equal(1)
			instance.scrollToPage(-1)
			expect(instance.activePageIndex).to.be.equal(1)
			instance.scrollToPage(4)
			expect(instance.activePageIndex).to.be.equal(1)
		})
	}),
	describe('Buttons state and logic', () => {
		it('There is a button for each page'),
		it('When I press button for page i, I am shown contents of page i'),
		it('The amount of visible page buttons is same as buttonPanelSize if number of pages > bps'),
		it('The amount of visible page buttons is same as number of pages if buttonPanelSize > #pagese')
		it('When I click the left rewind button, the app shows contents of page 0', () => {
			instance.scrollToPage(1)
			expect(instance.activePageIndex).to.be.equal(1)
			let leftRewind = wrapper.find('[id=left-rewind]')
			expect(leftRewind.is('button')).to.be.true
			leftRewind.trigger('click')
			expect(instance.activePageIndex).to.be.equal(0)
		}),
		it('When I click the right rewind button, the app shows contents of last page', () => {
			instance.scrollToPage(1)
			expect(instance.activePageIndex).to.be.equal(1)
			let rightRewind = wrapper.find('[id=right-rewind]')
			expect(rightRewind.is('button')).to.be.true
			rightRewind.trigger('click')
			expect(instance.activePageIndex).to.be.equal(3)
		}),
		it('Scroll left button disabled for page 0'),
		it('Scroll left button shows a new button for a lower number page'),
		it('Scroll right button disabled for last page'),
		it('Scroll left button shows a new button for a lower number page')
	}),
	describe('Slots and list logic', () => {
		it('Components in slots correspond to active page'),
		it('Number of visible components in the list is the same as property size for regular page'),
		it('Length of list is shorter for last page, if page length does not divide total')
	})
})
