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

    local status="$(echo ${component} | base64 --decode | jq -r '.scopes[0].status')"
    local status_id="$(_commit "SELECT status.id FROM api.statuses AS status WHERE status.name LIKE '${status}';" | awk '{$1=$1};1')"

    _commit "INSERT INTO api.components (name, description, status, deleted) VALUES (\$tag\$${name}\$tag\$,\$tag\$${description}\$tag\$,\$tag\$${status_id}\$tag\$,false);"

    local component_id="$(_commit "SELECT id from api.components order by id desc limit 1;" | awk '{$1=$1};1')"

    comments "${component_id}" "${component}"

    usecases "${component_id}" "${component}"

    links "${component_id}" "${component}"

    add_taxonomies "${component_id}" "${component}"

    links "${component_id}" "${component}"

  done <<< "$(cat frontend/src/api/mock/data/techComponents.json | jq -r '.[] | @base64')"
}

# Insert a comment
function comments () {
  local comments="$(echo ${2} | base64 --decode | jq -r -c '.comments')"
  if [ "${comments}" != '' ]; then
    _commit "INSERT INTO api.comments (comment, component, modifiedby, deleted) VALUES (\$tag\$${comments}\$tag\$,\$tag\$${1}\$tag\$,\$tag\$${MODIFIED_BY}\$tag\$,false);"
  fi
}

# Add taxonomies to component
function add_taxonomies () {
  while read -r tag; do

    local component_id="${1}"
    local tag_name="$(echo ${tag} | base64 --decode)"
    local taxonomy_id="$(_commit "SELECT taxonomy.id FROM api.taxonomy AS taxonomy WHERE upper(taxonomy.name) LIKE upper('${tag_name}');" | awk '{$1=$1};1')"

    if [ "${taxonomy_id}" != '' ]; then
      _commit "INSERT INTO api.component_taxonomy (component, taxonomy) VALUES (\$tag\$${component_id}\$tag\$,\$tag\$${taxonomy_id}\$tag\$);"
    fi
  done <<< "$(echo ${component} | base64 --decode | jq -r '.tags[] | @base64')"
}

# Add links
function links () {
  while read -r link; do
    local component_id="${1}"
    local url="$(echo ${link} | base64 --decode)"

    if [ "${url}" != '' ]; then
      if [ "${component_id}" != '' ]; then
        _commit "INSERT INTO api.links (url,component, modifiedby, deleted) VALUES (\$tag\$${url}\$tag\$,\$tag\$${component_id}\$tag\$,\$tag\$${MODIFIED_BY}\$tag\$,false);"
      fi
    fi

  done <<< "$(echo ${component} | base64 --decode | jq -r '.links[] | @base64')"
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
  while read -r scope; do
    _commit "INSERT INTO api.scopes (name, modifiedby, deleted) VALUES (\$tag\$${scope}\$tag\$,\$tag\$${MODIFIED_BY}\$tag\$,false);"
  done <<< "$(cat frontend/src/api/mock/data/techComponents.json | jq  '.[].scopes[].org' | sort | uniq | jq -s '.[]')"
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
