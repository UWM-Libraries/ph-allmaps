#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

./node_modules/.bin/allmaps transform geojson \
  -a annotation.json \
  < voiries1300_2009_clean.geometries.ndjson \
  > voiries1300_2009.svg
