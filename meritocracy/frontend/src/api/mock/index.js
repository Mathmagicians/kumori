import techComponents from './data/techComponents'

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
  }
}