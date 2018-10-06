# Required REST endpoints

## Security
  * GET /security/login?name=NAME&pwd=sha1-hash - expected return JWT token {pricipal: name, claim: {isAdmin: true}}

## components
 * GET /components - returns a paginated collection of components
 * POST /components - return the newly created component. Component id is set by backend



