#!/bin/bash

echo -n "Filename (minus the extension):"
read FILENAME

raspivid -o $FILENAME.h264 -t 0 -n -w 1280 -h 720 -b 10000000 --framerate 30 --keypress -v

MP4Box -add $FILENAME.h264 -fps 30 $FILENAME.mp4

rm $FILENAME.h264

echo "Saved $FILENAME.mp4"
