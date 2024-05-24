#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "No path to video provided"
  exit 1
fi

name=$(basename $1)
extension="${name##*.}"

top=$2
if [ -z "${top}" ]; then
  top=86
fi

ffmpeg -i $1  -vf "crop=out_w=in_w:out_h=in_h-$top:x=0:y=$top" temp.mp4

rm $1

mv temp.mp4 $1