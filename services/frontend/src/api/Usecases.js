import Postgrest from "./Postgrest.js";
export default {
  async update(id, name, description) {
    return new Postgrest("/api/usecases").update([`id=eq.${id}`],{
      name: name,
      description: description
    });
  },
  async insert(name, description) {
    return new Postgrest("/api/usecases").insert({
      name: name,
      description: description,
      deleted: false
    });
  },
  async deleteById(id) {
    //TODO Some of this should probably be handled on the database side as a trigger
    return new Postgrest("/api/usecase_taxonomy").delete([`usecase=eq.${id}`]).then(() => {
      return new Postgrest("/api/component_usecase").delete([`usecase=eq.${id}`])
        .then(() => {
          return new Postgrest("/api/usecases").delete([`id=eq.${id}`]);
        });
    })
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
