import axios from 'axios'
export default {
  /**
   * Update a project
   */
  update: function(id, name, description, scope) {
    let url = '/api/rpc/project_update'
    let config = {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('token')}`
      }
    }
    axios.post(url, {
        id: id,
        name: name,
        description: description,
        scope: scope
      }, config)
      .then(function(response) {
        callback(response)
      })
      .catch(function(error) {
        console.log(error);
      })
  },
  /**
   * List projects
   */
  list: function(offset, limit, callback) {
    let data = [{
      name: 'Project Suspicious',
      status: {
        value: 1,
        trend: 1,
        timestamp: '2018-08-21:00:00:00'
      },
      history: [{
        value: 1,
        trend: 1,
        timestamp: '2018-08-01:00:00:00'
      }, {
        value: 1,
        trend: 1,
        timestamp: '2018-07-21:00:00:00'
      }, {
        value: 1,
        trend: 1,
        timestamp: '2018-06-01:00:00:00'
      }]
    }, {
      name: 'Project Awesome',
      status: {
        value: 5,
        trend: -1,
        timestamp: '2018-08-21:00:00:00'
      },
      history: [{
        value: 1,
        trend: 1,
        timestamp: '2018-08-01:00:00:00'
      }, {
        value: 1,
        trend: 1,
        timestamp: '2018-07-21:00:00:00'
      }, {
        value: 1,
        trend: 1,
        timestamp: '2018-06-01:00:00:00'
      }]
    }]

    return data

    /*
    let url = '/api/w_projects?order=id.desc'
    let config = {
      headers: {
        'Range': `${offset}-${limit}`,
        'Range-Unit': 'items',
        'Prefer': 'count=exact'
      }
    }
    axios.get(url, config)
      .then(function(response) {
        let [page, total] = response.headers['content-range'].split('/')
        let [offset, limit] = page.split('-')
        callback(offset, limit, total, response.data)
      })
      .catch(function(error) {
        console.log(error)
        return []
      })
    */
  }
}
