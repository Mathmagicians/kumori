#!/usr/bin/env bash

declare -r S_PROT='http'
declare -r S_HOST='127.0.0.1'
declare -r S_PORT='9000'
declare -r S_USER='admin'
declare -r S_PASS='admin'

# Send request to Sonarqube
function _request() {
  local user='' pass='' login='' url='' data=''
  if [ -n "${3}" ]; then user="${3}"; fi
  if [ -n "${4}" ]; then pass="${4}"; fi
  if [ -n "${user}" ]; then login="${user}:"; fi
  if [ -n "${user}" ] && [ -n "${pass}" ]; then login="${user}:${pass}"; fi
  url="${S_PROT}://${login}@${S_HOST}:${S_PORT}"
  data="$(if [ -n "${2}" ]; then echo "--data ${2}"; fi)"

  curl -s \
  -H "Accept: application/json" \
  -H "Content-Type:application/x-www-form-urlencoded" \
  ${data} "${url}${1}"
}

# Send data to Sonarqube Rest API as admin
function _post(){
  _request "${1}" "${2}" "${S_USER}" "${S_PASS}"
}

# Create a user
function create_user() {
  _post "/api/users/create" "login=${1}&name=${2/ /%20}&password=${3}"
}

# Create a token for a user
function create_token() {
  _post "/api/user_tokens/generate" "name=${1}&login=${2}"
}

# Script entry point
function main() {
  create_user "${1}" "${2}" "${3}" > /dev/null
  create_token "scanning" "${1}" | jq -r '.token'
}

main "$@"
