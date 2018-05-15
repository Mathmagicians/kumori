Feature: Acquire application token and session.
  In order to send requests to Blackduckhub a application token and a session is required.

  Scenario: Perform login with valid credentials
     When a http "POST" request is send to "api/j_spring_security_check"
      And the post data is "j_username=valid_user&j_password=valid_user"
     Then a response is recived with http status 204
      And a the http header "Set-Cookie" contains /JSESSIONID=[0-9A-F]{32};path=\/;HttpOnly/
      And a the http header "X-CSRF-TOKEN" contains /[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{32}-[0-9A-F]{12}/

  Scenario: Perform login with invalid credentials
     When a http "POST" request is send to "api/j_spring_security_check"
      And the post data is "j_username=invalid_user&j_password=invalid_user"
     Then a response is recived with http status 401
      And a the http header "Set-Cookie" contains /JSESSIONID=[0-9A-F]{32};path=\/;HttpOnly/
      And a the http header "X-CSRF-TOKEN" contains /[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{32}-[0-9A-F]{12}/
      And a the http header "Content-Type" contains "application/json;charset=UTF-8"
      And the response body field "errorMessage" contains "Invalid username or password"
      And the response body field "errorMessage" contains "{core.rest.unauthenticated}"
