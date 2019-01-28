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

# Dump database
function dump () {
  local curdir="$(pwd)"
  cd ../frontend
  docker-compose -f docker-compose.dev.yml stop postgrest
  docker-compose -f docker-compose.dev.yml exec -u postgres postgres pg_dump -U "${USERNAME}" "${DATABASE}" > "${FILENAME}"
  docker-compose -f docker-compose.dev.yml start postgrest
  cd "${curdir}"
}

# Script entry point
function main () {
  dump
}

main
