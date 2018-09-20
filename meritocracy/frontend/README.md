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

The site will be available at: http://127.0.0.1:8080
The postgrest service will be available at:http://127.0.0.1:3000
The swagger ui will be available at:http://127.0.0.1:8070
The postgres ui will be avaialble at http://127.0.0.1:5050

For now, you need to bootstrap the database manually by running `make schema`, `make fixture` and `make load`

Get a shell with node

    $ make shell
