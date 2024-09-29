#!/usr/bin/env sh

thequote=$(curl -s https://zenquotes.io/api/random)

if [ -z "$thequote" ] ; then
  echo "..."
  exit 1
fi

quote=$(echo "$thequote" | jq '.[0].q')
author=$(echo "$thequote" | jq '.[0].a')

echo "$quote@@$author" | tr -d '"'
