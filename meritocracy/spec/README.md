# Verification BDD test suite for Meritocracy

## How to run 

### Gradle

Open a command window and run:

    ./gradlew test aggregate

### As Junit test
This runs Cucumber features using Cucumber's JUnit runner. The `@RunWith(CucumberWithSerenity.class)` annotation on the `CucumberTestSuite`
class tells JUnit to kick off Cucumber.

## Viewing the reports

Both of the commands provided above will produce a Serenity test report in the `target/site/serenity` directory. Type:

    ./gradlew showResults

## Overriding options

Using Gradle:

    ./gradlew -Dcucumber.options="..." test

That should list all the available options.

    -Dcucumber.options="--help"

You can also specify what to run by *tag*:

    -Dcucumber.options="--tags @bar --plugin pretty"

### Running only the scenarios that failed in the previous run

    -Dcucumber.options="@target/rerun.txt"

This works as long as you have the `rerun` formatter enabled.
