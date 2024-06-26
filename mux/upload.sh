#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "No path to video provided"
  exit 1
fi

dir=$(dirname "$(realpath "$0")")

mux_user=$(\
  grep "^USER=" $dir/.env | cut -d'=' -f2
)

response=$(\
  curl https://api.mux.com/video/v1/uploads \
    -X POST \
    -H "Content-Type: application/json" \
    -u $mux_user \
    -sS \
    -d "$(cat $dir/settings.json)" \
)

url=$(\
  echo $response \
  | jq -r '.data.url'\
)

upload_id=$(\
  echo $response \
  | jq -r '.data.id'\
)

curl -sS -v -X PUT -T $1 $url

asset_id=$(\
  curl https://api.mux.com/video/v1/uploads/${upload_id} \
    -X GET \
    -H "Content-Type: application/json" \
    -u $mux_user \
    -sS \
  | jq -r '.data.asset_id' \
)

asset_data=$(\
  curl https://api.mux.com/video/v1/assets/${asset_id} \
    -X GET \
    -H "Content-Type: application/json" \
    -u $mux_user \
    -sS \
)

file_name=$(basename $1)

id_file="$1.json"

echo $asset_data > $id_file

playback_id=$(\
  echo $asset_data \
  | jq -r '.data.playback_ids[0].id'\
)

echo "Done! Playback ID: $playback_id"