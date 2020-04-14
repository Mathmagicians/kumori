import axios from "axios";
export default class Postgrest {
  /**
   * Constructor
   */
  constructor(endpoint) {
    if (endpoint === undefined) {
      throw new Error("Endpoint not set");
    } else {
      this.endpoint = endpoint;
    }
  }

  async total() {
    let config = {
      headers: {
        Range: `0-0`,
        "Range-Unit": "items",
        Prefer: "count=exact"
      }
    };
    return axios.get(this.endpoint, config).then(response => {
      return Number(response.headers["content-range"].split("/")[1]);
    });
  }

  async update(clause, data) {
    let clauses = `?${this.clause(clause)}`;
    return this.hasToken().then(() => {
      let config = {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("token")}`
        }
      };
      return axios.patch(`${this.endpoint}${clauses}`, data, config);
    });
  }

  async insert(data) {
    return this.hasToken().then(() => {
      let config = {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("token")}`,
          Prefer: `resolution=merge-duplicates`
        }
      };
      return axios.post(this.endpoint, data, config);
    });
  }

  async delete(clause) {
    let clauses = `?${this.clause(clause)}`;
    return this.hasToken().then(() => {
      let config = {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("token")}`
        }
      };
      return axios.delete(`${this.endpoint}${clauses}`, config);
    });
  }

  async get(
    offset = 0,
    limit = 9,
    select = [],
    order = [],
    clause = ["id=gt.0"]
  ) {
    let clauses = `?${this.clause(clause)}`;
    let columns = this.select(select) === "" ? "" : `&${this.select(select)}`;
    let ordering = this.order(order) === "" ? "" : `&${this.order(order)}`;
    let arg = `${clauses}${columns}${ordering}`;
    let config = {
      headers: {
        Range: `${offset}-${limit}`,
        "Range-Unit": "items",
        Prefer: "count=exact"
      }
    };
    return axios.get(`${this.endpoint}${arg}`, config).then(function(response) {
      return {
        data: response.data,
        total: response.headers["content-range"].split("/")[1]
      };
    });
  }

  async hasToken() {
    return new Promise((resolve, reject) => {
      if (localStorage.getItem("token") !== null) {
        resolve();
      } else {
        reject(Error("No authentication token found"));
      }
    });
  }

  select(fields) {
    if (fields.constructor === Array && fields.length > 0) {
      return `select=${fields.join(",")}`;
    }
    return "";
  }

  order(fields) {
    if (fields.constructor === Array && fields.length > 0) {
      return `order=${fields.join(",")}`;
    }
    return "";
  }

  clause(fields) {
    if (fields.constructor === Array && fields.length > 0) {
      return `${fields.join("&")}`;
    }
    return "";
  }
}
