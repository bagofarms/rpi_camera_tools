#!/bin/bash

#Settings for 720p video
#WIDTH=1280
#HEIGHT=720
#BITRATE=10000000

#Settings for 1080p video
WIDTH=1920
HEIGHT=1080
BITRATE=17000000

#Frames per second for video capture
FPS=30

#View preview window while recording
#Note: Turning this on will ignore the VERBOSE setting
PREVIEW=true

#Verbose output from raspivid
#Note: This setting is ignored when PREVIEW=true
VERBOSE=true

#Set the ISO (sensitivity) of the image sensor (values: 100-800)
#Uncomment to set.  Comment out for default
#ISO=800

#Remove .h264 file after conversion to .mp4 is complete
REMOVE_H264=true
