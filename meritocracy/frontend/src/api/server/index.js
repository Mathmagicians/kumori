import axios from 'axios'

	const BASE_URL="http://0.0.0.0:3000/"

export default {
  fetchTechComponents() {
    return axios
      .get(`${BASE_URL}w_components`)
      .then(response => response.data)
  },

  fetchMeritocracy () {
  	return this.notImplemented("fetchMeritocracy")
  },

  fetchServices () {
  	return this.notImplemented("fetchServices")
  },

  fetchTaxonomy () {
  	 return this.notImplemented("fetchTaxonomy")
  },
  editTechComponent( techComponent ){
      return this.notImplemented("editTechComponent")
  },
  createTechComponent(techComponent){
    return this.notImplemented("createTechComponent")
  },

  notImplemented(name){
    console.log(`Not implemented ${name} in the backend - returning empty data`)
    return new Promise((resolve) => {
      resolve([])
  })
  }
}
