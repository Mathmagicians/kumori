import techComponents from './data/techComponents'
import meritocracy from './data/meritocracy'
import services from './data/services'
import taxonomy from './data/taxonomy'
//import usecases from '.data/token'
import token from './data/token'

import axios from 'axios'

const fetch = (mockData, time = 0) => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(mockData)
    }, time)
  })
}

export default {
  fetchTechComponents () {
    return fetch(techComponents, 1000); // wait 1s before returning posts
  },

  fetchTechComponentDetails(id) {
     return new Promise( (resolve) => resolve(techComponents).find( t => t.uid === id) )
  },
  fetchTechComponentsSize(){
    return new Promise( (resolve) => resolve(techComponents).length )
  },
  fetchUsecases () {
    return fetch( usecases, 200);
  },
  fetchMeritocracy () {
    return fetch(meritocracy, 2000);
  },

  fetchServices () {
    return fetch(services, 4000);
  },

  fetchTaxonomy () {
    return fetch(taxonomy,0);
  },
  editTechComponent( techComponent ){
      return fetch( techComponent, 100)
  },
  createTechComponent(techComponent){
    return fetch({...techComponent, uid: Date.now()}, 100)
  },
  login(credentials) {
      return fetch( token, 2000)
  },

  login2(credentials) {
    const instance = axios.create({
      baseURL: 'https://github.com/',
      timeout: 1000,
      headers: {'Access-Control-Allow-Origin': '*'}
    });

    return axios
      .get('https://github.com/login/oauth/authorize', 
        { params: {client_id: 'themathmagician', state: 'meritocracy', 'crossdomain': true, 'redirect-uri': 'http://localhost:8080/callback'}})
      .then(response => response.data)

  }
}
