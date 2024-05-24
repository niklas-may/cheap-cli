#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "You need to provie a name"
  exit 1
fi

name=$1
count=0

for file in ./*
do
  extension="${file##*.}"
  new_name="./$name-$count.$extension"
  mv -- "$file" "$new_name"
  count=$((count+1))
done