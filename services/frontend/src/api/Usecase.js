import Postgrest from "./Postgrest.js";
export default class Usecase {

  async update(id, name, description) {
    return new Postgrest("/api/usecases").update([`id=eq.${id}`], {
      name: name,
      description: description
    });
  }

  async insert(name, description) {
    return new Postgrest("/api/usecases").insert({
      name: name,
      description: description
    });
  }

  async setTaxonomy(usecase_id, taxonomy_id) {
    return new Postgrest("/api/usecase_taxonomy").insert({
      usecase: usecase_id,
      taxonomy: taxonomy_id
    });
  }

  async clearTaxonomy(id) {
    return new Postgrest("/api/usecase_taxonomy").delete([`usecase=eq.${id}`]);
  }

  async getTaxonomy(id) {
    return new Postgrest("/api/usecase_taxonomy").get([`usecase=eq.${id}`]);
  }

  async clearComponents(id) {
    return new Postgrest("/api/component_usecase").delete([`usecase=eq.${id}`]);
  }

  async deleteById(id) {
    return this.clearTaxonomy(id).then(() => {
      return this.clearComponents(id)
        .then(() => {
          return new Postgrest("/api/usecases").delete([`id=eq.${id}`]);
        });
    })
  }

  async get(
    offset = 1,
    limit = 10,
    select = [],
    order = [],
    clause = ["id=gt.0"]
  ) {
    return new Postgrest("/api/usecases").get(
      offset,
      limit,
      select,
      order,
      clause
    );
  }
};
