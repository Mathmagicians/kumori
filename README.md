[![Build Status](https://travis-ci.org/Mathmagicians/kumori.svg?branch=master)](https://travis-ci.org/Mathmagicians/kumori)
[![Sonar Status](https://sonarcloud.io/api/project_badges/measure?project=Mathmagicians_kumori&metric=alert_status)](https://sonarcloud.io/dashboard?id=Mathmagicians_kumori)

<img src="https://p14.zdusercontent.com/attachment/1015988/ILt64wv09EiSYlczYn9qT6sbO?token=eyJhbGciOiJkaXIiLCJlbmMiOiJBMTI4Q0JDLUhTMjU2In0..p5isVLQUoFjBFQxrbKuZ7A.pd5GzuefqEFeVonPbUT2RXV9zfcjOMeceoWh-DvzrUaKpmmoJ3bfFFsRGo3_hkwsz0WUlLCfibURlXnD3TUIuUarpqcEIScqbRDRImkgp8yp8pMrVsldZVcx3-pdyY0JsssrpGMxVBFEF-0sRpUU5fpcLLaR1SC9RjPsN7fRroQ45UOpYbfntVwaAIeEiKcVbqW4DSIyGJ2yqsYB4JCXKbo-kmLv9Y2huo87j4qbZnnvAUV2y99_QpPcl5KRDvsy6L4qXBasZU4bHa7YnE83CK5PphMORCfcAT7pAk9tgrU.58aljhq1tzvjb-BavJPb8w" width="100">

# Kumori

## Description

This project is about generating the architecture, roadmap and strategy using qualified experts - people that know about things should decide about things, and display the result in an easy to navigate way.

## Run
When you run this project, you start the production version of the application.
For development, checkout the startscript from the `frontend` folder.

    $ cp .env.sample .env

Update `.env` if necessary.

    $ cp docker-compose up -d

    -   The site will be available at: <http://127.0.0.1>
    -   The postgrest service will be available at:<http://127.0.0.1:3000>

## Milestones

### Milestone one - Technology governance

-   Components
-   Services
-   Blueprints
-   Patterns and principles

This projects uses [Browserstack](https://www.browserstack.com) for automated testing.
