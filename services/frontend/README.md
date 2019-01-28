# Meritocracy

This is the frontend for Kumori Meritocracy.

## Setup

Checkout project, and in a shell navigate to the kumori/meritocracy/frontend folder

Install all npm dependencies locally and fix prettier/index.js bug.

    $ make setup

## Build

Build the project for distribution.

    $ make build

## Test

Run all the test for the project.

    $ make test

CAVEAT: there is a bug in mocha, currently you need to :
comment out line 32893 of prettier/index.js.
See: <https://stackoverflow.com/questions/52202399/typeerror-super-expression-must-either-be-null-or-a-function/52204427>

Run the unit tests

    $ make unit

Run the backend tests (postgres/postgrest)

    $ make rest

## Dev environment

The dev environment includes the postgrest/postgres/swagger backend. You start it with docker-compose.

    $ cp .env.sample .env
    $ docker-compose -f docker-compose.dev.yml up

-   The site will be available at: <http://127.0.0.1>
-   The postgrest service will be available at:<http://127.0.0.1:3000>
-   The swagger ui will be available at:<http://127.0.0.1:8070>
-   The postgres ui will be available at <http://127.0.0.1:5050>

Default web token for for edit access is `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiZWRpdG9yIn0.tYUlheVyisdr0ezFYf92mC_dvSS02cpDvPBu9aKLySk`

You make generate new token for deployment here: <https://jwt.io/#debugger-io>
