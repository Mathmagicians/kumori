#!/usr/bin/env bash
set -e

declare USERNAME='postgres' DATABASE='meritocracy' FILENAME='dump.pgsql'

# Parse script arguments
GETOPT=$(getopt -n "$0"  -o '' --long "username:,database:,filename:"  -- "$@")
if [ $? -ne 0 ]; then exit 1; fi
eval set -- "$GETOPT"

while true;
do
  case "$1" in
    --username)
    if [ -n "$2" ]; then USERNAME="$2"; fi; shift 2;;
    --database)
    if [ -n "$2" ]; then DATABASE="$2"; fi; shift 2;;
    --filename)
    if [ -n "$2" ]; then FILENAME="$2"; fi; shift 2;;
    --)
      shift
      break;;
  esac
done

# Import database
function import () {
  local curdir="$(pwd)"
  cd ../frontend
  docker stop kumori-postgrest
  docker exec -i -u postgres kumori-postgres psql -U "${USERNAME}" < ../backend/database.sql
  docker exec -i -u postgres kumori-postgres psql -U "${USERNAME}" "${DATABASE}" < "${FILENAME}"
  docker start kumori-postgrest
  cd "${curdir}"
}

# Get fixture data
function getFixture () {
  local curdir="$(pwd)"
  cd ../frontend
  if [ ! -f dump.pgsql ]
  then
    curl -s -o dump.pgsql https://raw.githubusercontent.com/Mathmagicians/kumori/fixture/dump.pgsql
    cd "${curdir}"
  fi
}

# Script entry point
function main () {
  getFixture
  import
}

main
