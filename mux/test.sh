#!/usr/bin/env bash

dir=$(dirname "$(realpath "$0")")

mux_user=$(\
  grep "^USER=" $dir/.env | cut -d'=' -f2
)

echo $mux_user 