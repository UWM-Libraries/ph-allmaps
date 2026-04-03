#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

jq -c '
  .features[]
  | .geometry
  | if .type == "MultiLineString"
    then .coordinates[] | {type:"LineString",coordinates:.}
    else .
    end
' 'voiries1300_2009.json' > voiries1300_2009.geometries.ndjson

./node_modules/.bin/allmaps transform geojson \
  -a annotation.json \
  < voiries1300_2009.geometries.ndjson \
  > voiries1300_2009.svg
