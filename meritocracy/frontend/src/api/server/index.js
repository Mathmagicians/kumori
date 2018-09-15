import axios from 'axios'

export default {
  fetchPosts () {
    return axios
      .get('https://jsonplaceholder.typicode.com/tech-components')
      .then(response => response.data)
  }
}