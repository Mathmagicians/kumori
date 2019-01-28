import { shallowMount, mount, createLocalVue } from '@vue/test-utils'
import { expect } from 'chai'
import Home from '@/views/Home.vue'
import BootstrapVue from 'bootstrap-vue'

describe('Home', () => {
  it('should find "home" element when rendering the Home view', () => {
    const localVue = createLocalVue()
    localVue.use(BootstrapVue)
    const wrapper = shallowMount(Home, { localVue })
    expect(wrapper.isVueInstance()).to.equal(true)
    expect(wrapper.name()).to.equal('home')
    expect(wrapper.find('.home').exists()).to.be.true
  })
})