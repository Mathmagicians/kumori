#!/usr/bin/env bash
set -e

declare REPO='Mathmagicians/kumori'
declare PATH='https://${GITHUB_TOKEN}@api.github.com/repos/${REPO}/releases'

# Get all releases
function get_releases () {
  curl -s -X GET ${PATH}
}

# Get release by tag
function get_release () {
  curl -s -X GET ${PATH}/tags/${1}
}

# Create a release
function create_release () {
  local data

  data="{\"tag_name\": \"${1}\",\"target_commitish\": \"master\",\"name\":\"${2}\",\"body\": \"${3}\",\"draft\": false,\"prerelease\": false}"

  curl -s -X POST ${PATH} -d ${data}
}

# delete a release
function delete_release () {
  curl -s -X DELETE ${PATH}/${1}
}

# Get release id
function get_release_id () {
  local releases
  docker pull stedolan/jq
  get_release "v1.0.0-snapshot"
}

create_release "v1.0.1" "v1.0.1" "This is a test release."
