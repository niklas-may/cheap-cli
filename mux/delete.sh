#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "No folder name in uploads provided"
  exit 1
fi

dir=$(dirname "$(realpath "$0")")

mux_user=$(\
  grep "^USER=" $dir/.env | cut -d'=' -f2
)

file_name=$1.json

file=$(< $file_name)

id=$(\
  echo $file | jq -r '.data.id' \
)

curl -f https://api.mux.com/video/v1/assets/${id} \
  -X DELETE \
  -H "Content-Type: application/json" \
  -u $mux_user \
  -sS \

if [ $? -ne 0 ]; then
  echo "API request failed"
  exit 1
fi

rm -rf $file_name 

echo "Asset deleted successfully"