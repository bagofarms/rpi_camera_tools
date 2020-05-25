#!/bin/bash

source config.sh

if [ "$VERBOSE" = true ] ; then
	VERBOSE_STR="-v"
else
	VERBOSE_STR=""
fi

echo -n "Filename (minus the extension):"
read FILENAME

raspivid -o $FILENAME.h264 -t 0 -n -w $WIDTH -h $HEIGHT -b $BITRATE --framerate $FPS --keypress $VERBOSE_STR

MP4Box -add $FILENAME.h264 -fps $FPS $FILENAME.mp4

if [ "$REMOVE_H264" = true ] ; then
	rm $FILENAME.h264
	echo "Removing $FILENAME.h264"
fi
