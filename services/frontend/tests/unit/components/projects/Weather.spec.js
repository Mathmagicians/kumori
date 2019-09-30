import { shallowMount, createLocalVue } from "@vue/test-utils";
import { expect } from "chai";
import BootstrapVue from "bootstrap-vue";
import List from '@/components/projects/Weather.vue';

describe("/components/projects/Weather.vue", () => {

  it('Weather status 1', () => {
    const localVue = createLocalVue();
    localVue.use(BootstrapVue);
    const wrapper = shallowMount(List, {
      localVue,
      propsData: {
        state: 1
       }
    });
    expect(wrapper.html().includes('weather01')).to.equal(true)
  });

  it('Weather status 2', () => {
    const localVue = createLocalVue();
    localVue.use(BootstrapVue);
    const wrapper = shallowMount(List, {
      localVue,
      propsData: {
        state: 2
       }
    });
    expect(wrapper.html().includes('weather02')).to.equal(true)
  });

});
