import { shallowMount } from "@vue/test-utils";
import Weather from "@/components/Weather.vue";

describe("Weather.vue", () => {
  it("renders props.msg when passed", () => {
    const state = 1;
    const wrapper = shallowMount(Weather, {
      propsData: { state }
    });
    expect(wrapper.text()).toMatch("1");
  });
});
