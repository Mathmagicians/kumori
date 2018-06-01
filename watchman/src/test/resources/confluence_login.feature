Feature: Publish to Confluence
  In order to publish to Confluence we need to update Confluence pages

  Scenario: Login to Confluence
    Given I have a Confluence endpoint
    And a Confluence User named test-bot exists
    And a the Confluence User has a password
    And the Confluence User can login to Confluence using a password
	And a space for Techmenu exists

  #Scenario: 	
    #When a http "PUT" request is send to /rest\/api\/content\/[0-9]{8}/
    #And the http header "Accept" is "application/json"
    #And the page title is /[0-9A-Za-z\s]{255}/
    #And the page id is /[0-9]{8}/
    #And the space key is /[A-Z]{8}/
    #And the version is /[0-9]{8}/
    #And the body is /.*/	
    #Then a response is recived with http status 200
    #And the http header "Content-Type" contains "application/json"
    
  #Scenario: Get page version
    #When a http "GET" request is send to /rest\/api\/content\/[0-9]{8}/
    #And the http header "Accept" is "application/json"
    #Then a response is recived with http status 200
    #And the http header "Content-Type" contains "application/json"
    #And the response body field ".version .number" contains /[0-9]{8}/