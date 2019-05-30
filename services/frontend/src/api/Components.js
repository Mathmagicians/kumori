import Postgrest from "./Postgrest.js";
export default {
  async total() {
    return new Postgrest("/api/w_simple_components").total();
  },
  async update(id, name, description) {
    return new Postgrest("/api/components").update([`id=eq.${id}`],{
      name: name,
      description: description,
      deleted: false
    });
  },
  async get(
    offset = 0,
    limit = 9,
    select = [],
    order = [],
    clause = ["id=gt.0"]
  ) {
    return new Postgrest("/api/w_simple_components").get(
      offset,
      limit,
      select,
      order,
      clause
    );
  },
  async getC(
    offset = 0,
    limit = 9,
    select = [],
    order = [],
    clause = ["id=gt.0"]
  ) {
    return new Postgrest("/api/w_components").get(
      offset,
      limit,
      select,
      order,
      clause
    );
  }
};
