#!/usr/bin/env bash
PGDATABASE='meritocracy'
PGPASSWORD='postgres'

function _commit () {
  psql -U ${PGPASSWORD} -d ${PGDATABASE} -t -q -c "${1}"
}

function components () {
  _commit "DELETE FROM ${DB_SCHEMA}.comments;"
  _commit "DELETE FROM ${DB_SCHEMA}.usecases;"
  _commit "DELETE FROM ${DB_SCHEMA}.components;"

  while read -r component; do
    local name="$(echo ${component} | base64 -d | jq -r -c '.name')"
    local description="$(echo ${component} | base64 -d | jq -r -c '.description')"
    local status="$(echo ${component} | base64 -d | jq -r '.scopes[0].status')"
    local scope="$(echo ${component} | base64 -d | jq -r '.scopes[0].org')"

    local status_id="$(_commit "SELECT status.id FROM ${DB_SCHEMA}.statuses AS status WHERE status.name LIKE '${status}';" | awk '{$1=$1};1')"

    local scope_id="$(_commit "SELECT scope.id FROM ${DB_SCHEMA}.scopes AS scope WHERE scope.name LIKE '${scope}';" | awk '{$1=$1};1')"

    _commit "INSERT INTO ${DB_SCHEMA}.components (name, description, status, deleted) VALUES (\$tag\$${name}\$tag\$,\$tag\$${description}\$tag\$,\$tag\$${status_id}\$tag\$,false);"

    local component_id="$(_commit "SELECT id from ${DB_SCHEMA}.components order by id desc limit 1;" | awk '{$1=$1};1')"

    comments "${component_id}" "${component}"

    usecases "${component_id}" "${status_id}" "${scope_id}" "${component}"

    convert_scopes "${component_id}" "${component}"

    links "${component_id}" "${component}"

    add_taxonomies "${component_id}" "${component}"

    links "${component_id}" "${component}"

  done <<< "$(curl -s ${COMPONENTS} | jq -r '.[] | @base64')"
}

# Insert a comment
function comments () {
  local comments="$(echo ${2} | base64 -d | jq -r -c '.comments')"
  if [ "${comments}" != '' ]; then
    _commit "INSERT INTO ${DB_SCHEMA}.comments (comment, component, deleted) VALUES (\$tag\$${comments}\$tag\$,\$tag\$${1}\$tag\$,false);"
  fi
}

# Add taxonomies to component
function add_taxonomies () {
  while read -r tag; do

    local component_id="${1}"
    local tag_name="$(echo ${tag} | base64 -d)"
    local taxonomy_id="$(_commit "SELECT taxonomy.id FROM ${DB_SCHEMA}.taxonomy AS taxonomy WHERE upper(taxonomy.name) LIKE upper('${tag_name}');" | awk '{$1=$1};1')"

    if [ "${taxonomy_id}" != '' ]; then
      _commit "INSERT INTO ${DB_SCHEMA}.component_taxonomy (component, taxonomy) VALUES (\$tag\$${component_id}\$tag\$,\$tag\$${taxonomy_id}\$tag\$);"
    fi
  done <<< "$(echo ${component} | base64 -d | jq -r '.tags[] | @base64')"
}

# Add links
function links () {
  while read -r link; do
    local component_id="${1}"
    local ref="$(echo ${link} | base64 -d)"
    local type="Link"

    if [ "${ref}" != '' ]; then
      if [ "${component_id}" != '' ]; then
        _commit "INSERT INTO ${DB_SCHEMA}.links (ref,type,component, deleted) VALUES (\$tag\$${ref}\$tag\$,\$tag\$${type}\$tag\$,\$tag\$${component_id}\$tag\$,false);"
      fi
    fi

  done <<< "$(echo ${component} | base64 -d | jq -r '.links[] | @base64')"
}

function convert_scopes () {
  while read -r scopes; do
    local component="${1}"
    local description="Converted scope"
    local scope="$(echo ${scopes} | base64 -d| jq -r '.org')"
    local status="$(echo ${scopes} | base64 -d| jq -r '.status')"

    local name="Allowed for ${scope}"

    local status_id="$(_commit "SELECT status.id FROM ${DB_SCHEMA}.statuses AS status WHERE status.name LIKE '${status}';" | awk '{$1=$1};1')"

    local scope_id="$(_commit "SELECT scope.id FROM ${DB_SCHEMA}.scopes AS scope WHERE scope.name LIKE '${scope}';" | awk '{$1=$1};1')"

    if [ "${description}" != 'Any' ]; then
      _commit "INSERT INTO ${DB_SCHEMA}.usecases (component, name, description, scope, status, deleted) VALUES (\$tag\$${component}\$tag\$,\$tag\$${name}\$tag\$,\$tag\$${description}\$tag\$,\$tag\$${scope_id}\$tag\$,\$tag\$${status_id}\$tag\$,false);"
    fi

  done <<< "$(echo ${2} | base64 -d | jq -r '.scopes[] | @base64')"
}

# Insert a usecase
function usecases () {
  while read -r usecase; do
    local component="${1}"
    local name="Missing name for usecase"
    local description="$(echo ${usecase} | base64 -d)"
    local scope="${3}"
    local status="${2}"

    if [ "${description}" != 'Any' ]; then
      _commit "INSERT INTO ${DB_SCHEMA}.usecases (component, name, description, scope, status, deleted) VALUES (\$tag\$${component}\$tag\$,\$tag\$${name}\$tag\$,\$tag\$${description}\$tag\$,\$tag\$${scope}\$tag\$,\$tag\$${status}\$tag\$,false);"
    fi

  done <<< "$(echo ${4} | base64 -d | jq -r '.usecases[] | @base64')"
}

# Insert scopes
function scopes () {
  _commit "DELETE FROM ${DB_SCHEMA}.scopes;"
  while read -r scope; do
    _commit "INSERT INTO ${DB_SCHEMA}.scopes (name) VALUES (\$tag\$${scope}\$tag\$);"
  done <<< "$(curl -s ${COMPONENTS} | jq  '.[].scopes[].org' | sort | uniq | jq -s '.[]' | jq -r '.')"
}

# Insert statuses
function statuses () {
  _commit "DELETE FROM ${DB_SCHEMA}.statuses;"

  while read -r status; do
    name="$(echo ${status} | base64 -d)"
    _commit "INSERT INTO ${DB_SCHEMA}.statuses (name) VALUES (\$tag\$${name}\$tag\$);"
  done <<< "$(curl -s ${TAXONOMY} | jq -r '.statuses[] | @base64')"
}

# Create taxonomy
function taxonomi () {
  _commit "DELETE FROM ${DB_SCHEMA}.taxonomy;"
  while read -r component; do
    name="$(echo ${component} | base64 -d | jq -r -c '.name')"
    level="$(echo ${component} | base64 -d | jq -r -c '.level')"
    parent="$(echo ${component} | base64 -d | jq -r -c '.parent')"
    _commit "INSERT INTO ${DB_SCHEMA}.taxonomy (name, level, parent, deleted) VALUES (\$tag\$${name}\$tag\$,\$tag\$${level}\$tag\$,\$tag\$${parent}\$tag\$,false);"
  done <<< "$(curl -s ${TAXONOMY} | jq -r '.tags[] | @base64')"
}

if [ "${TAXONOMY}" != '' ]; then
  if [ "${COMPONENTS}" != '' ]; then
    taxonomi
    scopes
    statuses
    components
    echo "Import complete"
  else
    echo "Nothing imported"
  fi
fi
