import Postgrest from "./Postgrest.js";
export default {
  async total() {
    return new Postgrest("/api/w_simple_components").total();
  },
  async update(id, name, description) {
    return new Postgrest("/api/components").update([`id=eq.${id}`], {
      name: name,
      description: description,
      deleted: false
    });
  },
  async addUsecase(component, usecase, status, description) {
    if (typeof component !== 'number') {
      throw new Error(`'component' must be a number. Was '${typeof component}'`);
    }
    if (typeof usecase !== 'number') {
      throw new Error("usecase must be a number");
    }
    if (typeof status !== 'number') {
      throw new Error("status must be a number");
    }
    if (typeof description !== 'string') {
      throw new Error("description must be a string");
    }
    return new Postgrest("/api/component_usecase").insert({
      component: component,
      usecase: usecase,
      status: status,
      description: description,
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
