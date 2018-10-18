#!/usr/bin/env bash
set -e

declare PGDATABASE='meritocracy'
declare PGPASSWORD='postgres'
declare COMPONENTS_DATA TAXONOMY_DATA
declare -A STATUS_LOOKUP TAXONOMY_LOOKUP SCOPE_LOOKUP
declare VERBOSE=1

# Check input
function check_input () {
  COMPONENTS_DATA="$(curl -s "${COMPONENTS}")"
  TAXONOMY_DATA="$(curl -s "${TAXONOMY}")"

  if jq -e . >/dev/null 2>&1 <<<"${COMPONENTS_DATA}"; then
    print_message "Component JSON valid" "True"
  else
    print_message "Component JSON valid" "False"
    exit 1
  fi

  if jq -e . >/dev/null 2>&1 <<<"${TAXONOMY_DATA}"; then
    print_message "Taxonomy JSON valid" "True"
  else
    print_message "Taxonomy JSON valid" "False"
    exit 1
  fi
}

# Commit query to database
function _commit () {
  psql -U ${PGPASSWORD} -d ${PGDATABASE} -t -q -c "${1}"
}

# Insert components
function components () {
  local count current
  count="$(echo "${COMPONENTS_DATA}" | jq '. |length')"
  current=1

  while read -r component; do
    local name description status scope status_id scope_id component_id
    name="$(echo "${component}" | base64 -d | jq -r -c '.name')"
    description="$(echo "${component}" | base64 -d | jq -r -c '.description')"
    status="$(echo "${component}" | base64 -d | jq -r '.scopes[0].status')"
    scope="$(echo "${component}" | base64 -d | jq -r '.scopes[0].org')"
    status_id=${STATUS_LOOKUP["${status}"]}
    scope_id=${SCOPE_LOOKUP["${scope}"]}

    _commit "INSERT INTO ${DB_SCHEMA}.components (name, description, status, deleted) VALUES (\$tag\$${name}\$tag\$,\$tag\$${description}\$tag\$,\$tag\$${status_id}\$tag\$,false);"

    print_message "Added Component (${current}/${count})" "${name}"

    comments "${current}" "${component}"
    usecases "${current}" "${status_id}" "${scope_id}" "${component}"
    convert_scopes "${current}" "${component}"
    links "${current}" "${component}"
    add_taxonomies "${current}" "${component}"
    links "${current}" "${component}"
    current=$((current+1))
  done <<< "$(echo "${COMPONENTS_DATA}" | jq -r '.[] | @base64')"
}

# Insert comment
function comments () {
  local comments
  comments="$(echo "${2}" | base64 -d | jq -r -c '.comments')"

  if [ "${comments}" != '' ]; then
    _commit "INSERT INTO ${DB_SCHEMA}.comments (comment, component, deleted) VALUES (\$tag\$${comments}\$tag\$,\$tag\$${1}\$tag\$,false);"
    print_message_component "Added Comment" "${comments}"
  fi
}

# Insert tags
function add_taxonomies () {
  while read -r tag; do
    local component_id tag_name taxonomy_id
    component_id="${1}"
    tag_name="$(echo "${tag}" | base64 -d)"

    if [ "${tag_name}" != '' ]; then
      taxonomy_id=${TAXONOMY_LOOKUP["${tag_name}"]}
    fi

    if [ "${taxonomy_id}" != '' ]; then
      _commit "INSERT INTO ${DB_SCHEMA}.component_taxonomy (component, taxonomy) VALUES (\$tag\$${component_id}\$tag\$,\$tag\$${taxonomy_id}\$tag\$);"
      print_message_component "Added Tag" "${tag_name}"
    fi
  done <<< "$(echo "${component}" | base64 -d | jq -r '.tags[] | @base64')"
}

# Insert links
function links () {
  while read -r link; do
    local component_id ref link_type
    component_id="${1}"
    ref="$(echo "${link}" | base64 -d)"
    link_type="Link"

    if [ "${ref}" != '' ]; then
      if [ "${component_id}" != '' ]; then
        _commit "INSERT INTO ${DB_SCHEMA}.links (ref,type,component, deleted) VALUES (\$tag\$${ref}\$tag\$,\$tag\$${link_type}\$tag\$,\$tag\$${component_id}\$tag\$,false);"
        print_message_component "Added Link" "${ref}"
      fi
    fi

  done <<< "$(echo "${component}" | base64 -d | jq -r '.links[] | @base64')"
}

# Convert scopes to usecases
function convert_scopes () {
  while read -r scopes; do
    local component description scope status name status_id scope_id
    component="${1}"
    description="Converted scope"
    scope="$(echo "${scopes}" | base64 -d| jq -r '.org')"
    status="$(echo "${scopes}" | base64 -d| jq -r '.status')"
    name="Allowed for ${scope}"
    status_id=${STATUS_LOOKUP["${status}"]}
    scope_id=${SCOPE_LOOKUP["${scope}"]}

    if [ "${description}" != 'Any' ]; then
      _commit "INSERT INTO ${DB_SCHEMA}.usecases (component, name, description, scope, status, deleted) VALUES (\$tag\$${component}\$tag\$,\$tag\$${name}\$tag\$,\$tag\$${description}\$tag\$,\$tag\$${scope_id}\$tag\$,\$tag\$${status_id}\$tag\$,false);"
      print_message_component "Added Usecase" "${name}"
    fi

  done <<< "$(echo "${2}" | base64 -d | jq -r '.scopes[] | @base64')"
}

# Insert a usecase
function usecases () {
  while read -r usecase; do
    local component name description scope status
    component="${1}"
    name="Missing name for usecase"
    description="$(echo "${usecase}" | base64 -d)"
    scope="${3}"
    status="${2}"

    if [ "${description}" != 'Any' ]; then
      _commit "INSERT INTO ${DB_SCHEMA}.usecases (component, name, description, scope, status, deleted) VALUES (\$tag\$${component}\$tag\$,\$tag\$${name}\$tag\$,\$tag\$${description}\$tag\$,\$tag\$${scope}\$tag\$,\$tag\$${status}\$tag\$,false);"
      print_message_component "Added Usecase" "${name}"
    fi

  done <<< "$(echo "${4}" | base64 -d | jq -r '.usecases[] | @base64')"
}

# Create scopes
function scopes () {
  local current=1
  while read -r scope; do
    local scope_id
    _commit "INSERT INTO ${DB_SCHEMA}.scopes (name) VALUES (\$tag\$${scope}\$tag\$);"
    print_message "Added Scope" "${scope}"
    SCOPE_LOOKUP["${scope}"]="${current}"
    current=$((current+1))
  done <<< "$(echo "${COMPONENTS_DATA}" | jq  '.[].scopes[].org' | sort | uniq | jq -s '.[]' | jq -r '.')"
}

# Create statuses
function statuses () {
  local current=1
  while read -r status; do
    local name status_id
    name="$(echo "${status}" | base64 -d)"
    _commit "INSERT INTO ${DB_SCHEMA}.statuses (name) VALUES (\$tag\$${name}\$tag\$);"
    print_message "Added Status" "${name}"
    STATUS_LOOKUP["${name}"]="${current}"
    current=$((current+1))
  done <<< "$(echo "${TAXONOMY_DATA}" | jq -r '.statuses[] | @base64')"
}

# Create taxonomy
function taxonomi () {
  local current=1
  while read -r component; do
    local name level parent
    name="$(echo "${component}" | base64 -d | jq -r -c '.name')"
    level="$(echo "${component}" | base64 -d | jq -r -c '.level')"
    parent="$(echo "${component}" | base64 -d | jq -r -c '.parent')"
    _commit "INSERT INTO ${DB_SCHEMA}.taxonomy (name, level, parent) VALUES (\$tag\$${name}\$tag\$,\$tag\$${level}\$tag\$,\$tag\$${parent}\$tag\$);"
    print_message "Added Taxonomy Tag" "${name}"
    TAXONOMY_LOOKUP["${name}"]="${current}"
    current=$((current+1))
  done <<< "$(echo "${TAXONOMY_DATA}" | jq -r '.tags[] | @base64')"
}

# Print message
function print_message () {
  if [[ ${VERBOSE} -gt 0 ]] ; then
    local yellow nc
    yellow='\033[0;33m'
    nc='\033[0m'
    printf " -- %-25s: ${yellow}%s${nc}\n" "${1}" "${2}"
  fi
}

# Print component message
function print_message_component () {
  if [[ ${VERBOSE} -gt 1 ]] ; then
    local yellow='\033[0;33m'
    local nc='\033[0m'
    printf " -- -> %-25s: ${yellow}%s${nc}\n" "${1}" "${2}"
  fi
}

start="$(date +%s)"
if [ "${TAXONOMY}" != '' ]; then
  if [ "${COMPONENTS}" != '' ]; then
    check_input
    taxonomi
    scopes
    statuses
    components
    end="$(date +%s)"
    runtime=$((end-start))
    echo "Import compleded in: ${runtime}sec"
  else
    echo "Nothing imported"
  fi
fi