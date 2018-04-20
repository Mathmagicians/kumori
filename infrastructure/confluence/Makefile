CONFLUENCE_HOST=http://localhost:8090

.PHONY: setup setup test

setup:
	curl -s -u admin:admin -X POST -H 'Content-Type: application/json' -d '{"key":"KUMO","name":"Kumori","type":"global","description":{"plain":{"value":"kumori","representation":"plain"}}}' ${CONFLUENCE_HOST}/rest/api/space
	curl -s -u admin:admin -X POST -H 'Content-Type: application/json' -d '{"type":"page","title":"Kumori","space":{"key":"KUMO"},"body":{"storage":{"value":"<h1>Kumori</h1>","representation":"storage"}}}' ${CONFLUENCE_HOST}/rest/api/content/

test:
	curl -u admin:admin -X PUT -H 'Content-Type: application/json' -d'{"id":"720904","type":"page","title":"Kumori","space":{"key":"KUMO"},"body":{"storage":{"value":"<i class=\"test\">test</i>","representation":"storage"}},"version":{"number":3}}' ${CONFLUENCE_HOST}/rest/api/content/720904
