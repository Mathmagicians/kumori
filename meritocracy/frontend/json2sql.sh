#!/usr/bin/env bash
apt-get update
apt-get install jq
if [ -f postgres/fixture.sql ]; then rm postgres/fixture.sql; fi
while read -r component; do
  data="$(echo ${component} | base64 --decode | jq -r -c '.')"
  echo -e "INSERT INTO api.components (data) VALUES ('${data//\'/\'\'}');" >> postgres/fixture.sql
done <<< "$(jq -r '.[] | @base64' < src/api/mock/data/techComponents.json)"
