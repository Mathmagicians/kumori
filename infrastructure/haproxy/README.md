[![Build Status](https://travis-ci.org/Mathmagicians/kumori.svg?branch=master)](https://travis-ci.org/Mathmagicians/kumori)

# Kumori

Healthcheck of your architecture.

POC project for parsing git history into Postgres to be viewed by Grafana.

## Run

    $ docker-compose up

## Bootstrap

    $ make bootstrap

## Parse repository and populate Postgres

To build a docker image for parsing the repository:

    $ make build-parser-image

To populate with data based on current working dir:

    $ make populate

To populate using a specific local git repository:

    $ make populate REPO=/path/to/local/git/repo
