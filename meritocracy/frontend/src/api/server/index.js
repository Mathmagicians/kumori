import axios from 'axios'

	const BASE_URL="http://0.0.0.0:3000/"

export default {

  getData(url){
    return axios
      .get(`${BASE_URL}${url}`)
      .then(response => response.data)
      .catch((error) => onError(error))
  },

  fetchTechComponents() {
    return this.getData('w_components')
  },

  fetchMeritocracy () {
  	return this.notImplemented("fetchMeritocracy")
  },

  fetchServices () {
  	return this.notImplemented("fetchServices")
  },


  fetchTaxonomy () {
    let config = {headers: {'Accept': 'application/vnd.pgrst.object+json'}}

  	 return axios
      .get(`${BASE_URL}w_taxonomy`, config)
      .then(response => response.data)
      .catch((error) => onError(error))
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
  }, 

  onError( error ){
    console.log('Application encountered an error when communicating with backend:\\n', error.message)
    if (error.response) {
      console.log(error.response.data);
      console.log(error.response.status);
      console.log(error.response.headers);
      this.$router.push({name: 'not-found', params: {code: error.response.status, asset: url}})
    } else if (error.request) {
       console.log(error.request)
       this.$router.push({name: 'not-found', params: {code: error.request.status, asset: url}})
    } else {
      // Something happened in setting up the request that triggered an Error
      this.$router.push({name: 'error', params: {code: 500}})

    }
  }
}
