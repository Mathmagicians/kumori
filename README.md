![CI](https://github.com/Mathmagicians/kumori/workflows/CI/badge.svg)
[![Build Status](https://travis-ci.org/Mathmagicians/kumori.svg?branch=master)](https://travis-ci.org/Mathmagicians/kumori)
[![Sonar Status](https://sonarcloud.io/api/project_badges/measure?project=Mathmagicians_kumori&metric=alert_status)](https://sonarcloud.io/dashboard?id=Mathmagicians_kumori)

# Kumori

## Description

This project is about generating the architecture, roadmap and strategy using qualified experts - people that know about things should decide about things, and display the result in an easy to navigate way.

## Build
    make build

## Start in dev mode
    cp .env.sample .env // Update `.env` if necessary.
    make start-dev fixture

The site will be available at: <http://127.0.0.1>

## Start in prod mode
    cp .env.sample .env // Update `.env` if necessary.
    make start fixture

The site will be available at: <http://127.0.0.1>

You make generate new token for deployment here: <https://jwt.io/#debugger-io>

## Tests
    make test // It is required for the test to run that an environment is running (dev or prod)

### JMeter

Assuming JMeter is on your path, you have exported your JWT token in your shell, you can start the editor with the following command:

    jmeter -t ./services/jmeter/kumori.jmx -e -Jjwt=${KUMORI_JWT}

To run the JMeter test without gui and assuming you have exported your JWT token in your shell:
    make integration-test

This projects uses [Browserstack](https://www.browserstack.com) for automated testing.
