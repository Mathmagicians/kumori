

echo "{ \"data\" : \"$(cat test.html | sed 's/\"/\\\"/g')\"}"

var1='{"id":"720904","type":"page","title":"Kumori","space":{"key":"KUMO"},"body":{"storage":{"value":"<i class=\"test\">test</i>","representation":"storage"}},"version":{"number":3}}'

curl -u admin:admin -X PUT -H 'Content-Type: application/json' -d  http://localhost:8090/rest/api/content/720904
