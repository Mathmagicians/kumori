Feature: Acquire application token and session.
  In order to send requests to Blackduckhub a application token and a session is required.

  Background: I trie to login to the blackduck service
    Given I have a blackduck endpoint

  Scenario: Perform login with valid credentials
    #When a http "POST" request is send to the endpoint "api/j_spring_security_check"
    #And the post data is "j_username=valid_user&j_password=valid_user"
    #Then a response is received with http status 204
    #And a the http header contains a valid sessionid, x-csrf-token and content-type

  Scenario: Perform login with invalid credentials
    #When a http "POST" request is send to the endpoint "api/j_spring_security_check"
    #And the post data is "j_username=invalid_user&j_password=invalid_user"
    #Then a response is recived with http status 401
    #And a the http header contains a valid sessionid, x-csrf-token and content-type
    #And the response body field "errorMessage" contains "Invalid username or password"
    #And the response body field "errorMessage" contains "unauthenticated"
