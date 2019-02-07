# TODO

## Services

### Frontend

-   Edit
-   Authentication

### Backend

-   GET /security/login?name=NAME&pwd=sha1-hash - expected return JWT token {pricipal: name, claim: {isAdmin: true}}

#### Components
-   Construct primary keys as (id, name)
-   Use compound foreign keys (id, name) when referring objects
-   Full audit log on entities that are governed by Kumori
