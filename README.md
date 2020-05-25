# Raspberry Pi Camera Tools

This is a collection of helper scripts I've created to make using a Raspberry Pi camera a little easier.

## Setup

Clone the repository or download the zip and unzip to a directory on your Raspberry Pi:

`git clone git@github.com:bagofarms/rpi_camera_tools.git`

or

`git clone https://github.com/bagofarms/rpi_camera_tools.git`

Copy the sample configuration file into one you can modify:

`cp config.sample.sh config.sh`

Set permissions on the two script files to allow you to execute them:

`chmod 774 focus.sh record.sh`

## Usage

If your camera allows for manual focus, run `focus.sh` first:

`./focus.sh`

To exit focusing, press `x` and then `enter`.

To record a video, run:

`./record.sh`

To change settings, run:

`nano config.sh`
