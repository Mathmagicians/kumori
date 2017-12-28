#!/usr/bin/env bash

declare -r G_PROT='http'
declare -r G_HOST='127.0.0.1'
declare -r G_PORT='3000'
declare -r G_USER='admin'
declare -r G_PASS='admin'
declare -r G_URL="${G_PROT}://${G_USER}:${G_PASS}@${G_HOST}:${G_PORT}"

# Send data to Grafana Rest API
function post(){
  curl -v \
  -H "Accept: application/json" \
  -H "Content-Type:application/json" \
  -X POST --data "$1" "$2"
}

# Script entry point
function main() {
  post "$(cat ./datasources/postgres.json)" "${G_URL}/api/datasources"
  post "$(cat ./dashboards/mostmodified.json)" "${G_URL}/api/dashboards/db"
}

main
