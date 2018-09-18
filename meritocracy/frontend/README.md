# Meritocracy

This is the frontend for Kumori Meritocracy.

## Setup

Checkout project, and in a shell navigate to the kumori/meritocracy/frontend folder

Install all npm dependencies locally.

    $ make setup

## Build

Build the project for distribution.

    $ make build

## Test

Run all the test for the project.

    $ make test

Run the unit tests

    $ make unit

Run the e2e tests (Not working at this time)

    $ make e2e

## Dev environment

The dev environment includes the postgrest/postgres/swagger backend. You start it with docker-compose.

    $ docker-compose -f docker-compose.dev.yml up

For now, you need to bootstrap the database manually by running `cd postgres && make create_schema && make create_schema`

## Dev server only

Start the dev server with live reload. The server will be available at http://127.0.0.1:8080

    $ make serve-start

Show the logs from the dev server

    $ make serve-logs

Stop the dev server

    $ make serve-stop

Get a shell with node

    $ make shell
