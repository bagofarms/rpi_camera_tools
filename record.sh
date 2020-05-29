#!/bin/bash

source config.sh

if [[ $PREVIEW = true ]] ; then
	PREVIEW_STR="-p"
else
	PREVIEW_STR=""
fi

if [[ $VERBOSE = true ]] ; then
	VERBOSE_STR="-v"
else
	VERBOSE_STR=""
fi

if [[ $ISO ]] ; then
	ISO_STR="--ISO $ISO"
else
	ISO_STR=""
fi

echo -n "Filename (minus the extension):"
read FILENAME

echo "raspivid -o $FILENAME.h264 -t 0 -n -w $WIDTH -h $HEIGHT -b $BITRATE --framerate $FPS --keypress $PREVIEW_STR $VERBOSE_STR $ISO_STR"

raspivid -o $FILENAME.h264 -t 0 -n -w $WIDTH -h $HEIGHT -b $BITRATE --framerate $FPS --keypress $PREVIEW_STR $VERBOSE_STR $ISO_STR

MP4Box -add $FILENAME.h264 -fps $FPS $FILENAME.mp4

if [ "$REMOVE_H264" = true ] ; then
	rm $FILENAME.h264
	echo "Removing $FILENAME.h264"
fi
