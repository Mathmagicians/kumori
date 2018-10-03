#!/usr/bin/env bash
PGDATABASE='meritocracy'
PGPASSWORD='postgres'
PG_HOST='postgres'

function _commit () {
  psql -U ${PGPASSWORD} -h ${PG_HOST} -d ${PGDATABASE} -t -q -c "${1}"
}

function components () {
  _commit "DELETE FROM api.comments;"
  _commit "DELETE FROM api.components;"

  while read -r component; do
    local name="$(echo ${component} | base64 --decode | jq -r -c '.name')"
    local description="$(echo ${component} | base64 --decode | jq -r -c '.description')"
    if [ "${description}" == '' ]
    then
      description='Missing'
    fi

    _commit "INSERT INTO api.components (name, description, deleted) VALUES (\$tag\$${name}\$tag\$,\$tag\$${description}\$tag\$,false);"

    local component_id="$(_commit "SELECT id from api.components order by id desc limit 1;" | awk '{$1=$1};1')"

    local comments="$(echo ${component} | base64 --decode | jq -r -c '.comments')"

    if [ "${comments}" != '' ]
    then
      comment "${comments}" "${component_id}"
    fi

  done <<< "$(cat src/api/mock/data/techComponents.json | jq -r '.components[] | @base64')"
}

# Insert a comment
function comment () {
  _commit "INSERT INTO api.comments (comment, component,deleted) VALUES (\$tag\$${1}\$tag\$,\$tag\$${2}\$tag\$,false);"
}

# Insert a usecase
function usecase () {
  _commit "INSERT INTO api.usecases (comment, component) VALUES (\$tag\$${1}\$tag\$,\$tag\$${2}\$tag\$);"
}

# Create taxonomy
function taxonomi () {
  _commit "DELETE FROM api.taxonomy;"
  while read -r component; do
    name="$(echo ${component} | base64 --decode | jq -r -c '.name')"
    level="$(echo ${component} | base64 --decode | jq -r -c '.level')"
    parent="$(echo ${component} | base64 --decode | jq -r -c '.parent')"
    _commit "INSERT INTO api.taxonomy (name, level, parent) VALUES (\$tag\$${name}\$tag\$,\$tag\$${level}\$tag\$,\$tag\$${parent}\$tag\$);"
  done <<< "$(src/api/mock/data/taxonomy.json | jq -r '.tags[] | @base64')"
}


components
taxonomi
