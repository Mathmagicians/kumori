import axios from "axios";
export default {
  /**
   * Update a usecase
   */
  update: function(id, name, description, callback) {
    let url = "/api/rpc/usecase_update";
    let config = {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`
      }
    };
    axios
      .post(
        url,
        {
          name: name,
          id: id,
          description: description
        },
        config
      )
      .then(function(response) {
        callback(response);
      })
      .catch(function(error) {
        console.log(error);
      });
  },
  /**
   * Update a usecase
   */
  list: function(offset, limit, callback) {
    let url = "/api/w_usecases?order=id.desc";
    let config = {
      headers: {
        Range: `${offset}-${limit}`,
        "Range-Unit": "items",
        Prefer: "count=exact"
      }
    };
    axios
      .get(url, config)
      .then(function(response) {
        let [page, total] = response.headers["content-range"].split("/");
        let [offset, limit] = page.split("-");
        callback(offset, limit, total, response.data);
      })
      .catch(function(error) {
        console.log(error);
        return [];
      });
  }
};
