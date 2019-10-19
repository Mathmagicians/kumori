import Postgrest from "./Postgrest.js";
export default class Taxonomy {
  async list() {
    return new Postgrest("/api/taxonomy")
      .get(1, 100, [], ["level.asc"], [])
      .then(response => {
        return response.data;
      });
  }
};
