#!/usr/bin/env bash

declare TOKEN="${1}"
declare AUTH="Authorization: Bearer ${TOKEN}"
declare CONTENT="Content-Type: application/json"
declare HOST="${2}"

function print_test () {
    local yellow nc
    yellow='\033[0;33m'
    nc='\033[0m'
    printf " -> %-25s ${yellow}%-6s${nc}: [%s] %s\n" "${1}" "${2}" "${3}" "${4}"
}

function parse_location () {
  local line
  while read p; do
    if [ "${p:0:9}" == 'Location:' ]; then
      echo "$(echo "${p}" | tr -d '\n' | tr -d '\r' | awk -F "." '{print $2}')"
      break
    fi
  done </tmp/headers.txt
}

# Test CRUD for comments
function test_comments () {
  local url method data response_status
  url='/comments'

  function comment_create () {
    data='{"comment": "This is a test","component": 1,"deleted": false}'
    response_status="$(curl -s -D /tmp/headers.txt -w "%{http_code}" "${HOST}${url}" -X POST -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 201 ]];
      then print_test "Comment" "Create" "OK";
      else print_test "Comment" "Create" "FAILED" "${response_status}";
    fi
  }

  function comment_read () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X GET -H "${AUTH}" -H "${CONTENT}")"
    if [[ ${response_status} == 200 ]];
      then print_test "Comment" "Read" "OK";
      else print_test "Comment" "Read" "FAILED" "${response_status}";
    fi
  }

  function comment_update () {
    data='{"comment": "Active Directory 3"}'
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X PATCH -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Comment" "Update" "OK";
      else print_test "Comment" "Update" "FAILED" "${response_status}";
    fi
  }

  function comment_delete () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X DELETE -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Comment" "Delete" "OK";
      else print_test "Comment" "Delete" "FAILED" "${response_status}";
    fi
  }
    comment_create
    comment_read
    comment_update
    comment_delete
}


# Test CRUD for Usecases
function test_usecases () {
  local url method data response_status
  url='/usecases'

  function usecase_create () {
    data='{"name":"Awesome","description": "test","scope":1,"status":1,"deleted": false}'
    response_status="$(curl -s -D /tmp/headers.txt -w "%{http_code}" "${HOST}${url}" -X POST -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 201 ]];
      then print_test "Usecase" "Create" "OK";
      else print_test "Usecase" "Create" "FAILED" "${response_status}";
    fi
  }

  function usecase_read () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X GET -H "${AUTH}" -H "${CONTENT}")"
    if [[ ${response_status} == 200 ]];
      then print_test "Usecase" "Read" "OK";
      else print_test "Usecase" "Read" "FAILED" "${response_status}";
    fi
  }

  function usecase_update () {
    data='{"description": "Test 2"}'
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X PATCH -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Usecase" "Update" "OK";
      else print_test "Usecase" "Update" "FAILED" "${response_status}";
    fi
  }

  function usecase_delete () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X DELETE -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Usecase" "Delete" "OK";
    else print_test "Usecase" "Delete" "FAILED" "${response_status}";
    fi
  }
    usecase_create
    usecase_read
    usecase_update
    usecase_delete
}

# Test CRUD for Components
function test_components () {
  local url method data response_status
  url='/components'

  function component_create () {
    data='{"name": "Hula","description": "test","deleted": false}'
    response_status="$(curl -s -D /tmp/headers.txt -w "%{http_code}" "${HOST}${url}" -X POST -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 201 ]];
      then print_test "Component" "Create" "OK";
      else print_test "Component" "Create" "FAILED" "${response_status}";
    fi
  }

  function component_read () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X GET -H "${AUTH}" -H "${CONTENT}")"
    if [[ ${response_status} == 200 ]];
      then print_test "Component" "Read" "OK";
      else print_test "Component" "Read" "FAILED" "${response_status}";
    fi
  }

  function component_update () {
    data='{"description": "Hula Hop"}'
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X PATCH -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Component" "Update" "OK";
      else print_test "Component" "Update" "FAILED" "${response_status}";
    fi
  }

  function component_delete () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X DELETE -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Component" "Delete" "OK";
      else print_test "Component" "Delete" "FAILED" "${response_status}";
    fi
  }
    component_create
    component_read
    component_update
    component_delete
}

# Test CRUD for Links
function test_links () {
  local url method data response_status
  url='/links'

  function links_create () {
      data='{"ref": "http://www.example.com","type": "Link","component":1,"deleted": false}'
    response_status="$(curl -s -D /tmp/headers.txt -w "%{http_code}" "${HOST}${url}" -X POST -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 201 ]];
      then print_test "Links" "Create" "OK";
      else print_test "Links" "Create" "FAILED" "${response_status}";
    fi
  }

  function links_read () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X GET -H "${AUTH}" -H "${CONTENT}")"
    if [[ ${response_status} == 200 ]];
      then print_test "Links" "Read" "OK";
      else print_test "Links" "Read" "FAILED" "${response_status}";
    fi
  }

  function links_update () {
    data='{"ref": "http://www.nowhere.com"}'
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X PATCH -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Links" "Update" "OK";
      else print_test "Links" "Update" "FAILED" "${response_status}";
    fi
  }

  function links_delete () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X DELETE -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Links" "Delete" "OK";
    else print_test "Links" "Delete" "FAILED" "${response_status}";
    fi
  }
    links_create
    links_read
    links_update
    links_delete
}

# Test CRUD for component usecases
function test_component_usecase () {
  local url method data response_status
  url='/component_usecase'

  function component_usecase_create () {
      data='{"component":1,"usecase": 20}'
    response_status="$(curl -s -D /tmp/headers.txt -w "%{http_code}" "${HOST}${url}" -X POST -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 201 ]];
      then print_test "Component Usecase" "Create" "OK";
      else print_test "Component Usecase" "Create" "FAILED" "${response_status}";
    fi
  }

  function component_usecase_read () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?component=eq.1&usecase=eq.20" -X GET -H "${AUTH}" -H "${CONTENT}")"
    if [[ ${response_status} == 200 ]];
      then print_test "Component Usecase" "Read" "OK";
      else print_test "Component Usecase" "Read" "FAILED" "${response_status}";
    fi
  }

  function component_usecase_update () {
    data='{"usecase": 22}'
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?component=eq.1&usecase=eq.20" -X PATCH -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Component Usecase" "Update" "OK";
      else print_test "Component Usecase" "Update" "FAILED" "${response_status}";
    fi
  }

  function component_usecase_delete () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?component=eq.1&usecase=eq.22" -X DELETE -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Component Usecase" "Delete" "OK";
    else print_test "Component Usecase" "Delete" "FAILED" "${response_status}";
    fi
  }
    component_usecase_create
    component_usecase_read
    component_usecase_update
    component_usecase_delete
}

# Test CRUD for usecase taxonomy
function test_usecase_taxonomy () {
  local url method data response_status
  url='/usecase_taxonomy'

  function usecase_taxonomy_create () {
      data='{"usecase":1,"taxonomy": 1}'
    response_status="$(curl -s -D /tmp/headers.txt -w "%{http_code}" "${HOST}${url}" -X POST -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 201 ]];
      then print_test "Usecase Taxonomy" "Create" "OK";
      else print_test "Usecase Taxonomy" "Create" "FAILED" "${response_status}";
    fi
  }

  function usecase_taxonomy_read () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?usecase=eq.1&taxonomy=eq.1" -X GET -H "${AUTH}" -H "${CONTENT}")"
    if [[ ${response_status} == 200 ]];
      then print_test "Usecase Taxonomy" "Read" "OK";
      else print_test "Usecase Taxonomy" "Read" "FAILED" "${response_status}";
    fi
  }

  function usecase_taxonomy_update () {
    data='{"usecase": 2}'
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?usecase=eq.1&taxonomy=eq.1" -X PATCH -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Usecase Taxonomy" "Update" "OK";
      else print_test "Usecase Taxonomy" "Update" "FAILED" "${response_status}";
    fi
  }

  function usecase_taxonomy_delete () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?usecase=eq.2&taxonomy=eq.1" -X DELETE -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Usecase Taxonomy" "Delete" "OK";
    else print_test "Usecase Taxonomy" "Delete" "FAILED" "${response_status}";
    fi
  }
    usecase_taxonomy_create
    usecase_taxonomy_read
    usecase_taxonomy_update
    usecase_taxonomy_delete
}

# Test CRUD for Scope
function test_scopes () {
  local url method data response_status
  url='/scopes'

  function scope_create () {
    data='{"name": "Nifty"}'
    response_status="$(curl -s -D /tmp/headers.txt -w "%{http_code}" "${HOST}${url}" -X POST -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 201 ]];
      then print_test "Scope" "Create" "OK";
      else print_test "Scope" "Create" "FAILED" "${response_status}";
    fi
  }

  function scope_read () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X GET -H "${AUTH}" -H "${CONTENT}")"
    if [[ ${response_status} == 200 ]];
      then print_test "Scope" "Read" "OK";
      else print_test "Scope" "Read" "FAILED" "${response_status}";
    fi
  }

  function scope_update () {
    data='{"name": "Niftyness"}'
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X PATCH -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Scope" "Update" "OK";
      else print_test "Scope" "Update" "FAILED" "${response_status}";
    fi
  }

  function scope_delete () {
    response_status="$(curl -s -o /dev/null -w "%{http_code}" "${HOST}${url}?id=eq.$(parse_location)" -X DELETE -H "${AUTH}" -H "${CONTENT}" -d "${data}")"
    if [[ ${response_status} == 204 ]];
      then print_test "Scope" "Delete" "OK";
      else print_test "Scope" "Delete" "FAILED" "${response_status}";
    fi
  }
    scope_create
    scope_read
    scope_update
    scope_delete
}

echo "Waiting for postgrest to become ready:"
until $(curl --output /dev/null --silent --head --fail http://127.0.0.1:3000); do
    printf '.'
    sleep 5
done
echo ""
test_comments
test_components
test_usecases
test_links
test_scopes
test_component_usecase
test_usecase_taxonomy
