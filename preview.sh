#!/bin/bash

raspivid -f -t 0 -k -v --mode 0 -w 1920 -h 1080 --framerate 30
