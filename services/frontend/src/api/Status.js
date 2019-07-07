import Postgrest from "./Postgrest.js";
export default class Status {
  async get(
    offset = 0,
    limit = 9,
    select = [],
    order = [],
    clause = ["id=gt.0"]
  ) {
    return new Postgrest("/api/statuses").get(
      offset,
      limit,
      select,
      order,
      clause
    );
  }
};
