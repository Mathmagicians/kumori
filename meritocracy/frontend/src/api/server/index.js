import axios from 'axios'

export default {
  fetchTechComponents() {
    return axios
      .get('https://jsonplaceholder.typicode.com/tech-components')
      .then(response => response.data)
  }
}
