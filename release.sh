#!/usr/bin/env bash
set -e

declare MAJOR=0
declare MINOR=1
declare PATCH=0
declare RELEASE="v${MAJOR}.${MINOR}.${PATCH}"
declare BUILD_RELEASE="v${MAJOR}.${MINOR}.${PATCH}-${TRAVIS_BUILD_NUMBER:-999}"

declare REPO='Mathmagicians/kumori'
declare API_PATH="https://${GITHUB_TOKEN}@api.github.com/repos/${REPO}/releases"
declare REPO_PATH="https://${GITHUB_TOKEN}@github.com/${REPO}.git"

# Get all releases
function get_releases () {
  /usr/bin/curl -s -X GET ${API_PATH}
}

# Get release by tag
function get_release () {
  /usr/bin/curl -s -X GET ${API_PATH}/tags/${1}
}

# Create a release
function create_release () {
  local data

  data=$(/usr/bin/jq \
   --arg key0   'tag_name' \
   --arg value0 ${1} \
   --arg key1   'target_commitish' \
   --arg value1 'master' \
   --arg key2   'name' \
   --arg value2 ${2} \
   --arg key3   'body' \
   --arg value3 "$(cat release.md)" \
   --arg key4   'draft' \
   --arg key5   'prerelease' \
   '. | .[$key0]=$value0 | .[$key1]=$value1 | .[$key2]=$value2 | .[$key3]=$value3 | .[$key4]=false | .[$key5]=false' \
   <<<'{}')

  if [ "$(release_exists ${1})" -eq "1" ]; then
    local id
    id=$(get_release "${1}" | /usr/bin/jq -c '.id')
    /usr/bin/curl -s -X PATCH ${API_PATH}/${id} -d "${data}" | /usr/bin/jq -c -r '.html_url'
  else
    /usr/bin/curl -s -X POST ${API_PATH} -d "${data}" | /usr/bin/jq -c -r '.html_url'
  fi
}

# Delete a release
function delete_release () {
  if [ "$(release_exists ${1})" -eq "1" ]; then
    local id
    id=$(get_release "${1}" | /usr/bin/jq -c '.id')
    /usr/bin/curl -s -X DELETE ${API_PATH}/${id}
    /usr/bin/git push --delete "${REPO_PATH}" ${1}
  else
    echo "No release found"
  fi
}

# Get release id
function get_release_id () {
  get_release "${1}" | /usr/bin/jq -c -r '.id'
}

# Get asset path
function get_asset_path () {
  get_release "${1}" | /usr/bin/jq -c -r '.assets_url'
}

# Check if a release exists
release_exists () {
  local message
  message="$(get_release "${1}" | /usr/bin/jq -c -r '.message')"
  if [ "${message}" = "null" ]; then echo 1; else echo 0; fi
}

function add_asset () { # NOT working yet
  /usr/bin/curl -s -X POST -H "Content-Type: text/markdown" -d "@./README.md" $(get_asset_path "${1}")?name=README.md
}

#get_asset_path "${BUILD_RELEASE}"
#add_asset "${BUILD_RELEASE}"

create_release "${BUILD_RELEASE}" "${BUILD_RELEASE}" "" "false" "false"
#delete_release "${BUILD_RELEASE}"
