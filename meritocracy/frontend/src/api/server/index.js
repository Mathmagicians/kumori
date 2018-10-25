import axios from 'axios'

	const BASE_URL="http://0.0.0.0:3000/"
  const COMPONENTS_READ ="w_components"

export default {

  getData(url, config={}, responseBehavior = (response) => response.data){
    return axios
      .get(url, config)
      .then(responseBehavior)
      .catch((error) => this.onError(error))
  },
  postData(url, toPost){
    return axios
      .post( url, toPost)
      .then( (response) => {console.log(response.data); return response.data})
      .catch( (error) => this.onError(error))
  },
  urlBuilder(apiurl,params){
    return `${BASE_URL}${apiurl}${this.paramsToUrl(params)}`
  },
  paramsToUrl(params){
    return Object.keys(params).reduce( (acc, pk) => `${acc}${pk}=${params[pk]}&` , '?')
  },
  configForRange(from,to){
    let conf = {
      headers: 
      {
        'Prefer': 'count=exact',
        'Range-Unit': 'w_components',
        'Range': `${from}-${to}`
      }
    }
    return conf
  },
  configForSingleObject(){
    let conf = {
      headers: {
        'Accept': 'application/vnd.pgrst.object+json'
      }
    }
    return conf
  },
  configForResponseOnChange(){
    const conf = {
      headers: {
        'Prefer': 'return=representation'
      }
    }
    return conf
  },
  constructResponseAsPage(response){
    const [current,total] = response.headers['content-range'].split('/')
    const [to, from] = current.split('-')
    const page = {from, to, total: Number(total), content: response.data}
    return page
  },

  //TODO move search serverside, then we will not have to fetch the full component list anymore
  //currently we are getting in the headers only with information necessary to search
  fetchTechComponents() {
    return this.getData(this.urlBuilder(COMPONENTS_READ, {select: 'uid,name,status,tags'}))
  },
  fetchTechComponentsHeadersPage(from=0, to=10){
    return this.getData( 
      this.urlBuilder(COMPONENTS_READ, {select: 'name,status,tags'}), 
      this.configForRange(from, to),
      this.constructResponseAsPage)
  },
  fetchTechComponentDetails(id) {
    return this.getData( 
      this.urlBuilder(COMPONENTS_READ, {uid:`eq.${id}`}), 
      this.configForSingleObject())
  },
  fetchTechComponentsSize() {
    return this.getData(
      this.urlBuilder(COMPONENTS_READ, {select: 'name'}), 
      this.configForRange(0,0),
      (response) => { 
        console.log(`We are interested in ${response.headers['content-range']} `)
        const [current,total] = response.headers['content-range'].split('/')
        return Number(total)
      })
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
  fetchUsecases () {
    return this.getData('w_usecases')
  },
  
  editTechComponent(techComponent){
      return this.postData(this.urlBuilder(COMPONENTS_READ), techComponent, configForResponseOnChange())
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
    console.log(`Application encountered an error when communicating with backend:\n${error.message}`)
    if (error.response) {
      console.log('>>> error in response >>>')
      console.log(error.response.data);
      console.log(error.response.status);
      console.log(error.response.headers);
      this.$router.push({name: 'not-found', params: {code: error.response.status, asset: url}})
    } else if (error.request) {
      console.log('>>> error in request >>>')
       console.log(error.request)
       this.$router.push({name: 'not-found', params: {code: error.request.status, asset: url}})
    } else {
      console.log('Something happened in setting up the request that triggered an Error')
      this.$router.push({name: 'error', params: {code: 500}})

    }
  }
}
