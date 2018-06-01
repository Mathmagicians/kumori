Feature: Publish to Confluence 
	In order to publish to Confluence we need to update Confluence pages

Scenario: Watchman can read the Confluence page using GET 
	Given I have a Confluence endpoint 
	And a Confluence User exists 
	And the Confluence User has a password 
	When the Confluence User sends a GET request to the Confluence endpoint with simple authentication username and password 
	Then a response is received with status 200 
	
	# curl -u admin:admin -X PUT -H 'Content-Type: application/json' -d'{"
	#id":"3604482","type":"page","title":"new page",
	#"space":{"key":"TST"},
	#"body":{"storage":{"value":
	#"<p>This is the updated text for the new page</p>","representation":"storage"}},
	#"version":{"number":2}}' http://localhost:8080/confluence/rest/api/content/3604482 
	
	
Scenario: Watchman can change the Confluence page using PUT 
	Given I have a content 
	And I construct an HTTP request 
	And the method is "PUT" 
	And the http header "Accept" is "application/json" 
	And the url is the Confluence endpoint 
	And the payload is a JSON object 
	And the payload contains a pair with key id and value confluence.page.id 
	And the payload contains a pair with key type and value "page" 
	And the payload contains a pair with key title and value confluence.page.title 
	And the payload contains an object space 
	And the object space contains a pair with key key and value confluence.page.key 
	And the payload contains the object body 
	And the object body contains the object storage 
	And the object storage contains a pair with key "value" and value content 
	When  I send the request 
	Then I receive a response 
	And the response has HTTP status 200 
	And the response payload is a JSON object 
	And the payload contains the object body 
	And the object body contains the object storage 
	And the object storage contains a pair with key "value" and value content 
	
	
