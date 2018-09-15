import posts from './data/components'

const fetch = (mockData, time = 0) => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(mockData)
    }, time)
  })
}

export default {
  fetchTechComponents () {
    return fetch(components, 1000) // wait 1s before returning posts
  }
}