# Required REST endpoints

## General principles
* All entities have a unique id, name id
* Dont return null values for lists, return empty arrays instead []
* Dont return null values for nullable fields, either "" or omit the field

## Security
  * GET /security/login?name=NAME&pwd=sha1-hash - expected return JWT token {pricipal: name, claim: {isAdmin: true}}

## components
 * GET /components - returns a paginated collection of components << paginated not ready yet
 * POST /components - return the newly created component. Component id is set by backend
 * GET /components?id.eq.{id}  - returns a component with a given {id}
 * PUT /components/uid - updates components with payload



