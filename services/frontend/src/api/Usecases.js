import Postgrest from "./Postgrest.js";
export default {
  async update(id, name, description) {
    return new Postgrest("/api/rpc/usecase_update").update({
      name: name,
      id: id,
      description: description
    });
  },
  async get(
    offset = 1,
    limit = 10,
    select = [],
    order = [],
    clause = ["id=gt.0"]
  ) {
    return new Postgrest("/api/w_usecases").get(
      offset,
      limit,
      select,
      order,
      clause
    );
  }
};
