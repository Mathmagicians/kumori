import techComponents from './data/techComponents'
import meritocracy from './data/meritocracy'
import services from './data/services'
import taxonomy from './data/taxonomy'

const fetch = (mockData, time = 0) => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(mockData)
    }, time)
  })
}

export default {
  fetchTechComponents () {
    return fetch(techComponents, 1000) // wait 1s before returning posts
  },

  fetchMeritocracy () {
    return fetch(meritocracy, 2000)
  },

  fetchServices () {
    return fetch(services, 4000)
  },

  fetchTaxonomy () {
    return fetch(taxonomy, 0)
  }
}
