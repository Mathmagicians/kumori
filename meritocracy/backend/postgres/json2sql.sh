#!/usr/bin/env bash
PGDATABASE='meritocracy'
PGPASSWORD='postgres'
PG_HOST='postgres'
MODIFIED_BY='John Doe'

function _commit () {
  psql -U ${PGPASSWORD} -h ${PG_HOST} -d ${PGDATABASE} -t -q -c "${1}"
}

function components () {
  _commit "DELETE FROM api.comments;"
  _commit "DELETE FROM api.usecases;"
  _commit "DELETE FROM api.components;"

  while read -r component; do
    local name="$(echo ${component} | base64 --decode | jq -r -c '.name')"
    local description="$(echo ${component} | base64 --decode | jq -r -c '.description')"
    if [ "${description}" == '' ]
    then
      description='Missing'
    fi

    _commit "INSERT INTO api.components (name, description, modifiedby, deleted) VALUES (\$tag\$${name}\$tag\$,\$tag\$${description}\$tag\$,\$tag\$${MODIFIED_BY}\$tag\$,false);"

    local component_id="$(_commit "SELECT id from api.components order by id desc limit 1;" | awk '{$1=$1};1')"

    comments "${component_id}" "${component}"

    usecases "${component_id}" "${component}"

  done <<< "$(cat frontend/src/api/mock/data/techComponents.json | jq -r '.[] | @base64')"
}

# Insert a comment
function comments () {
  local comments="$(echo ${2} | base64 --decode | jq -r -c '.comments')"
  if [ "${comments}" != '' ]; then
    _commit "INSERT INTO api.comments (comment, component, modifiedby, deleted) VALUES (\$tag\$${comments}\$tag\$,\$tag\$${1}\$tag\$,\$tag\$${MODIFIED_BY}\$tag\$,false);"
  fi
}

# Insert a usecase
function usecases () {
  while read -r usecase; do
    local component="${1}"
    local taxonomy='1'
    local description="$(echo ${usecase} | base64 --decode)"
    local scope='1'
    local status='1'

    _commit "INSERT INTO api.usecases (component, taxonomy, description, scope, status, modifiedby, deleted) VALUES (\$tag\$${component}\$tag\$,\$tag\$${taxonomy}\$tag\$,\$tag\$${description}\$tag\$,\$tag\$${scope}\$tag\$,\$tag\$${status}\$tag\$,\$tag\$${MODIFIED_BY}\$tag\$,false);"

  done <<< "$(echo ${component} | base64 --decode | jq -r '.usecases[] | @base64')"
}

# Insert scopes
function scopes () {
  _commit "DELETE FROM api.scopes;"
  local scopes=("Typical Taoists Inc")

  for i in "${scopes[@]}"; do
      _commit "INSERT INTO api.scopes (name, modifiedby, deleted) VALUES (\$tag\$${i}\$tag\$,\$tag\$${MODIFIED_BY}\$tag\$,false);"
  done
}

# Insert statuses
function statuses () {
  _commit "DELETE FROM api.statuses;"
  local scopes=("To be decided" "Experiment" "Testing" "POC" "Default" "Limited" "Deprecated" "Do not use")

  for i in "${scopes[@]}"; do
      _commit "INSERT INTO api.statuses (name, modifiedby, deleted) VALUES (\$tag\$${i}\$tag\$,\$tag\$${MODIFIED_BY}\$tag\$,false);"
  done
}

# Create taxonomy
function taxonomi () {
  _commit "DELETE FROM api.taxonomy;"
  while read -r component; do
    name="$(echo ${component} | base64 --decode | jq -r -c '.name')"
    level="$(echo ${component} | base64 --decode | jq -r -c '.level')"
    parent="$(echo ${component} | base64 --decode | jq -r -c '.parent')"
    _commit "INSERT INTO api.taxonomy (name, level, parent,  modifiedby, deleted) VALUES (\$tag\$${name}\$tag\$,\$tag\$${level}\$tag\$,\$tag\$${parent}\$tag\$,\$tag\$${MODIFIED_BY}\$tag\$,false);"
  done <<< "$(cat frontend/src/api/mock/data/taxonomy.json | jq -r '.tags[] | @base64')"
}

taxonomi
scopes
statuses
components
