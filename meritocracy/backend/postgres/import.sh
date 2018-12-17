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
  local count current pri_use
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

    _commit "INSERT INTO ${DB_SCHEMA}.components (name, description, deleted) VALUES (\$tag\$${name}\$tag\$,\$tag\$${description}\$tag\$,false);"

    print_message "Added Component (${current}/${count})" "${name}"

    comments "${current}" "${component}"
    usecases "${current}" "${status_id}" "${scope_id}" "${component}"
    convert_scopes "${current}" "${component}"
    links "${current}" "${component}"

    # Get a primary usecases
    pri_use="$(_commit "SELECT usecase FROM ${DB_SCHEMA}.component_usecase WHERE component = ${current} LIMIT 1;" | xargs)"

    if [ "${pri_use}" != '' ]; then
      _commit "UPDATE api.components SET primary_usecase = ${pri_use} WHERE id = ${current};"

      print_message_component "Added primary usecase" "${pri_use}"
    fi
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

# Insert tags on usecases
function add_taxonomies () {
  while read -r tag; do
    local usecase_id tag_name taxonomy_id
    usecase_id="${1}"
    tag_name="$(echo "${tag}" | base64 -d)"

    if [ "${tag_name}" != '' ]; then
      taxonomy_id=${TAXONOMY_LOOKUP["${tag_name}"]}
    fi

    if [ "${taxonomy_id}" != '' ]; then
      _commit "INSERT INTO ${DB_SCHEMA}.usecase_taxonomy (usecase, taxonomy) VALUES (\$tag\$${usecase_id}\$tag\$,\$tag\$${taxonomy_id}\$tag\$);"
      print_message_component "Added Taxonomy to Usecase" "${tag_name}"
    fi
  done <<< "$(echo "${2}" | base64 -d | jq -r '.tags[] | @base64')"
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
  local component description scope status name status_id scope_id status_1 status_2 status_3 scope_1 scope_2 scope_3

  status_1="$(echo "${2}" | base64 -d | jq -r '.scopes[0].status')"
  status_2="$(echo "${2}" | base64 -d | jq -r '.scopes[1].status')"
  status_3="$(echo "${2}" | base64 -d | jq -r '.scopes[2].status')"

  scope_1="$(echo "${2}" | base64 -d | jq -r '.scopes[0].org')"
  scope_2="$(echo "${2}" | base64 -d | jq -r '.scopes[1].org')"
  scope_3="$(echo "${2}" | base64 -d | jq -r '.scopes[2].org')"

  if [ "${status_1}" = "${status_2}" ] && [ "${status_2}" = "${status_3}" ]
  then
    if [ "${status_3}" != "To be decided" ]
    then
       add_usecase "${1}" "Converted scope" "Allowed for All"  "${SCOPE_LOOKUP["${scope_1}"]}" "${STATUS_LOOKUP["${status_1}"]}" "${2}"
    fi
  else
    if [ "${status_1}" != "To be decided" ]; then
      add_usecase "${1}" "Converted scope" "${status_1} for ${scope_1}" "${SCOPE_LOOKUP["${scope_1}"]}" "${STATUS_LOOKUP["${status_1}"]}" "${2}"
    fi
    if [ "${status_2}" != "To be decided" ]; then
      add_usecase "${1}" "Converted scope" "${status_2} for ${scope_2}" "${SCOPE_LOOKUP["${scope_1}"]}" "${STATUS_LOOKUP["${status_1}"]}" "${2}"
    fi
    if [ "${status_3}" != "To be decided" ]; then
      add_usecase "${1}" "Converted scope" "${status_3} for ${scope_3}" "${SCOPE_LOOKUP["${scope_1}"]}" "${STATUS_LOOKUP["${status_1}"]}" "${2}"
    fi
  fi
}

# Insert usecases for a component
function usecases () {
  local current
  while read -r usecase; do
    local component name description scope status
    component_id="${1}"
    name="Missing name for usecase"
    description="$(echo "${usecase}" | base64 -d)"
    scope="${3}"
    status="${2}"

    if [ "${description}" != 'Any' ]; then
      add_usecase "${component_id}" "${name}" "${description}" "${scope}" "${status}" "${4}"
    fi

  done <<< "$(echo "${4}" | base64 -d | jq -r '.usecases[] | @base64')"
}

# Insert a usecase
function add_usecase () {
  local component_id name description scope_id status component current

  component_id="${1}"
  name="${2}"
  description="${3}"
  scope_id="${4}"
  status_id="${5}"
  component="${6}"

  _commit "INSERT INTO ${DB_SCHEMA}.usecases (name, description, scope, deleted) VALUES (\$tag\$${name}\$tag\$,\$tag\$${description}\$tag\$,\$tag\$${scope_id}\$tag\$,false);"

  current="$(_commit "SELECT id FROM ${DB_SCHEMA}.usecases ORDER BY id DESC LIMIT 1;" | xargs)"

  _commit "INSERT INTO ${DB_SCHEMA}.component_usecase (component, usecase,status) VALUES (\$tag\$${component_id}\$tag\$,\$tag\$${current}\$tag\$,\$tag\$${status_id}\$tag\$);"
  print_message_component "Added Usecase" "${name}"
  add_taxonomies "${current}" "${component}"
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
    local name
    name="$(echo "${status}" | base64 -d | jq -r -c '.name')"
    phase="$(echo "${status}" | base64 -d | jq -r -c '.phase')"
    _commit "INSERT INTO ${DB_SCHEMA}.statuses (name, phase) VALUES (\$tag\$${name}\$tag\$, \$tag\$${phase}\$tag\$);"
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
