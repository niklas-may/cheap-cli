#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "No path to video provided"
  exit 1
fi




name=$(basename $1)
extension="${name##*.}"

crop=$2
if [ -z "${crop}" ]; then
  crop=3
fi

# Get video width
width=$(ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 $1)

# Subtract 3 pixels from the width
new_width=$((width - crop))

echo $new_width

# Crop the video
ffmpeg -i $1 -filter:v "crop=$new_width:in_h:0:0" temp.mp4

rm $1

mv temp.mp4 $1