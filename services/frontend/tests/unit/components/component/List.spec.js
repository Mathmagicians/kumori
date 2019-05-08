import { shallowMount, createLocalVue } from "@vue/test-utils";
import { expect } from "chai";
import BootstrapVue from "bootstrap-vue";
import List from '@/components/component/List.vue';

describe("/components/component/List.vue", () => {

  it('Provides pagination', () => {
    const localVue = createLocalVue();
    localVue.use(BootstrapVue);
    const wrapper = shallowMount(List, {
      localVue
    });
    //console.log(wrapper.html())
    expect(wrapper.contains('b-pagination-stub')).to.equal(true)
  });

  it('Displays a spinner when there is no items', () => {
    const localVue = createLocalVue();
    localVue.use(BootstrapVue);
    const wrapper = shallowMount(List, {
      localVue
    });
    expect(wrapper.contains('b-spinner-stub')).to.equal(true)
  });

});
