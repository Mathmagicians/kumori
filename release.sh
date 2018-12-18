#!/usr/bin/env bash

# Release API documentation
# https://developer.github.com/v3/repos/releases/

set -e

declare MAJOR=0
declare MINOR=1
declare PATCH=0
declare RELEASE="v${MAJOR}.${MINOR}.${PATCH}"
declare BUILD_RELEASE="v${MAJOR}.${MINOR}.${PATCH}-${TRAVIS_BUILD_NUMBER:-999}"
declare REPO='Mathmagicians/kumori'
declare API_PATH="https://${GITHUB_TOKEN}@api.github.com/repos/${REPO}/releases"
declare REPO_PATH="https://${GITHUB_TOKEN}@github.com/${REPO}.git"
declare ACTION=0

# Parse script arguments
GETOPT=$(getopt -n "$0"  -o '' --long "create,delete,publish"  -- "$@")
if [ $? -ne 0 ]; then exit 1; fi
eval set -- "$GETOPT"

while true;
do
  case "$1" in
    --create)
      ACTION=1; shift;;
    --delete)
      ACTION=2; shift;;
    --publish)
      ACTION=3; shift;;
    --)
      shift
      break;;
  esac
done

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
   --arg value3 "$(cat release.md | sed "s/{TAG}/${1}/g")" \
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
    cat meritocracy/.env.sample | sed "s/MERITOCRACY_VERSION=dev/MERITOCRACY_VERSION=${BUILD_RELEASE}/" > ./env.sample
    add_asset "${BUILD_RELEASE}" "text/plain" "env.sample" | /usr/bin/jq -c -r '.browser_download_url'
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

# Check if a release exists
function release_exists () {
  local message
  message="$(get_release "${1}" | /usr/bin/jq -c -r '.message')"
  if [ "${message}" = "null" ]; then echo 1; else echo 0; fi
}

# Add asset to release
function add_asset () {
  /usr/bin/curl -s -X POST -H "Content-Type: ${2}" -d "@./${3}" "https://${GITHUB_TOKEN}@uploads.github.com/repos/Mathmagicians/kumori/releases/$(get_release_id "${1}")/assets?name=${3}"
}

function publish () {
  docker tag "mathmagicians/meritocracy_web:latest" "mathmagicians/meritocracy_web:${1}"
  docker tag "mathmagicians/meritocracy_db:latest" "mathmagicians/meritocracy_db:${1}"
  docker push "mathmagicians/meritocracy_web:latest"
  docker push "mathmagicians/meritocracy_db:latest"
  docker push "mathmagicians/meritocracy_web:${1}"
  docker push "mathmagicians/meritocracy_db:${1}"
}

#get_release "${BUILD_RELEASE}"

#add_asset "${BUILD_RELEASE}" "text/plain" "CHANGELOG.md"

#create_release "${BUILD_RELEASE}" "${BUILD_RELEASE}" "" "false" "false"
#publish "${BUILD_RELEASE}"
#delete_release "${BUILD_RELEASE}"

# Script entry point
function main () {
  if [ "${ACTION}" == "1" ]; then create_release "${BUILD_RELEASE}" "${BUILD_RELEASE}" "" "false" "false"; fi
  if [ "${ACTION}" == "2" ]; then delete_release "${BUILD_RELEASE}"; fi
  if [ "${ACTION}" == "3" ]; then publish "${BUILD_RELEASE}"; fi
}

main
