import { shallowMount } from '@vue/test-utils'
import Home from '@/components/Home'

describe('Home', () => {
  it('should render the home component', () => {
  	const wrapper = shallowMount( Home, {})
  	expect.wrapper.find('#techmenu').exists().toBeTruthy()
  })
})
