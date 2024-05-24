#!/usr/bin/env bash

dir=$(dirname "$(realpath "$0")")

bash $dir/delete.sh $1 
bash $dir/upload.sh $1 