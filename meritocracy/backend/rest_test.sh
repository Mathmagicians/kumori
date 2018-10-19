#!/usr/bin/env bash

declare TOKEN="${1}"
declare AUTH="Authorization: Bearer ${TOKEN}"
declare CONTENT="Content-Type: application/json"
declare HOST='http://localhost:3000'

function print_test () {
    local yellow nc
    yellow='\033[0;33m'
    nc='\033[0m'
    printf " -> %-15s ${yellow}%-6s${nc}: [%s] %s\n" "${1}" "${2}" "${3}" "${4}"
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

test_comments
