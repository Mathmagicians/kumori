#!/usr/bin/env bash
set -e

# Add data to existing list of components
function import () {
  local COMPONENTS_DATA="$(cat techComponents.json)"
  while read p; do
    local uid name description comments tags licenses links usecases scopes entry
    name="${p}"
    description="Apache project"
    uid="$(echo "${name}${description}" | base64)"
    comments='This is a Apache project.'
    tags='["Delivery Services","Development","Design and Development"]'
    licenses='[]'
    links='["https://projects.apache.org"]'
    usecases='["May be used for experiments."]'
    scopes='[{"org": "Typical Taoists Inc","status": "Default"},{"org":"Gigantic Teleporters Inc","status": "To be decided"},{"org": "Brave Traders Inc","status": "To be decided"}]'
    entry="$(echo '{"uid":"'${uid}'","name":"'${name}'","description":"'${description}'","comments":"'${comments}'","tags":'${tags}',"licenses":'${licenses}',"links":'${links}',"usecases":'${usecases}',"scopes":'${scopes}'}')"
    COMPONENTS_DATA="$(echo "${COMPONENTS_DATA}" | jq ".[. | length] |= . + ${entry}")"

  done <"${1}"
  echo "${COMPONENTS_DATA}" | jq '. | sort_by(.name)' >> "${2}"
}

import "${1}" "${2}"
