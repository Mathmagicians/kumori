[![Build Status](https://travis-ci.org/Mathmagicians/kumori.svg?branch=master)](https://travis-ci.org/Mathmagicians/kumori)

# Kumori

Healthcheck of your architecture

# How to build

    $ ./gradlew build

# How setup confluence for testing

    $ docker-compose create
    $ docker-compose up

The first time you do this you will be asked to perform a setup.

Please select trial setup and provide a license.

Please create the user `admin` with password `admin` for use with testing.

# How to run
    $ java -jar build/libs/kumori-0.1.0.jar
