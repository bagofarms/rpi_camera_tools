#!/bin/bash

echo -n "Filename (minus the extension):"
read FILENAME

raspivid -o $FILENAME.h264 -t 0 -n -w 1920 -h 1080 -b 1700000 --framerate 30 --keypress -v

MP4Box -add $FILENAME.h264 -fps 30 $FILENAME.mp4

rm $FILENAME.h264

echo "Saved $FILENAME.mp4"
