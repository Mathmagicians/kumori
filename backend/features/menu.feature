Feature: Publish menu to Confluence
  In order to publish menu to Confluence we need to update Confluence page

  Background:
    Given a Confluence user "xxxxx" exist
    And "xxxxx" can login to Confluence
    And "xxxxx" have "write" access to the "yyyyy" space
    And "xxxxx" have "write" access to the "zzzzz" page
    And the page title is "Test"
    And the page id is "12345678"
    And the space key is "TEST"
    And the version is "2"

  Scenario: Update page content
    When a http "PUT" request is send to /rest\/api\/content\/[0-9]{8}/
    And the http header "Accept" is "application/json"
    And the body is """
    <table><thead><tr><th>Header</th></tr></thead><tbody><tr><th>Content</th></tr></tbody></table>
    """
    Then a response is recived with http status 200
    And the http header "Content-Type" contains "application/json"
    And the response body field ".body .content" contains """
    <table><thead><tr><th>Header</th></tr></thead><tbody><tr><th>Content</th></tr></tbody></table>
    """
