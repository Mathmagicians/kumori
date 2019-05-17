import Postgrest from "./Postgrest.js";
export default {
  async sunburst() {
    return new Postgrest("/api/w_burst")
      .get(1, 100, [], ["level.asc"], [])
      .then(response => {
        return response.data;
      });
  }
};
