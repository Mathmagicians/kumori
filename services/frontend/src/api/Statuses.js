import axios from "axios";
export default {
  async total() {
    return this.hasToken().then(() => {
      let url = "/api/statuses";
      let config = {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("token")}`,
          Range: `0-0`,
          "Range-Unit": "items",
          Prefer: "count=exact"
        }
      };
      return axios.get(url, config).then(function(response) {
        return response.headers["content-range"].split("/")[1];
      });
    });
  },
  async get(
    offset = 0,
    limit = 9,
    select = [],
    order = [],
    clause = ["id=gt.0"]
  ) {
    return this.hasToken().then(() => {
      let clauses = `?${this.clause(clause)}`;
      let columns = this.select(select) === "" ? "" : `&${this.select(select)}`;
      let ordering = this.order(order) === "" ? "" : `&${this.order(order)}`;
      let arg = `${clauses}${columns}${ordering}`;
      let url = `/api/statuses${arg}`;
      let config = {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("token")}`,
          Range: `${offset}-${limit}`,
          "Range-Unit": "items",
          Prefer: "count=exact"
        }
      };
      return axios.get(url, config).then(function(response) {
        return {
          data: response.data,
          total: response.headers["content-range"].split("/")[1]
        };
      });
    });
  },
  async hasToken() {
    return new Promise((resolve, reject) => {
      if (localStorage.getItem("token") !== null) {
        resolve();
      } else {
        reject(Error("No authentication token found"));
      }
    });
  },
  select(fields) {
    if (fields.constructor === Array && fields.length > 0) {
      return `select=${fields.join(",")}`;
    }
    return "";
  },
  order(fields) {
    if (fields.constructor === Array && fields.length > 0) {
      return `order=${fields.join(",")}`;
    }
    return "";
  },
  clause(fields) {
    if (fields.constructor === Array && fields.length > 0) {
      return `${fields.join("&")}`;
    }
    return "";
  }
};
