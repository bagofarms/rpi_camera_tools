# A runbook of sorts for the Raspberry Pi Camera

Before I start rambling, I recommend [the official documentation](https://www.raspberrypi.org/documentation/raspbian/applications/camera.md), as it's extremely thorough.

## Streaming Dreams

At first, I wanted to stream to YouTube or Twitch with the camera, so I investigated a few options until I found that you could send the output to `/dev/stdin`.  This first one streams out to port 8554:

First, we need to set up the camera for streaming:

`sudo modprobe bcm2835-v4l2`

Then, we run this crazy thing:

`raspivid -o - -t 0 -n | cvlc -vvv stream:///dev/stdin --sout '#rtp{sdp=rtsp://:8554/}' :demux=h264`

Some key points from this:

* `-o -` sends the stream to `/sev/stdin`
* `-t 0` records indefinitely
* The output gets piped to the console version of VLC, `cvlc`.

I also discovered that I could open VLC normally and skip the output to see the camera output directly in VLC:

`raspivid -o - -t 0 -n | vlc -vvv stream:///dev/stdin :demux=h264`

## Focusing the Camera

I decided to go back and try to set up the camera a bit better before worrying about streaming.  The following sets up a window at a reasonable resolution that maintains a good framerate for focus adjustment:

`raspistill -o ~/focustest.jpg -t 0 -k -v --mode 2`

Some key points from this:

* `-k` lets you hit enter to take a still image (saved to `~/focustest.jpg`).  Pressing `x` and then enter quits the application and writes one last still image to `~/focustest.jpg`.  That last point is important, because I kept wondering why it wasn't taking the picture when I told it to.  It WAS taking the picture, it just took it again and overwrote the original when I exited the application.
* `-v` puts the application into verbose mode, which also adds helper text for the keypresses.
* `--mode 2` sets the HQ camera to 2028x1520 with full FOV.  I chose this because the framerate could be up to 50fps, and it is 4:3 like the monitor I'm previewing on.

## Recording Locally

I was able to get good quality 720p recordings like this:

`raspivid -o presenting_test.h264 -t 0 -n -w 1280 -h 720 -b 10000000 --framerate 30 --keypress`

Some key points from this:

* `-n` disables the preview.
* `-w 1280 -h 720` sets the dimentions of the video.
* `-b 10000000` sets the bitrate to 10Mbps, which is great for 720p.
* `--framerate 30` sets the capture framerate, but this is not saved to the .h264 file. (More on this later.)
* `--keypress` lets you hit enter to stop and start the recording, or `x` followed by enter to stop.

I discovered that the video did not play at the right speed all the time, and it would skip sometimes on different players.  I came to find out that the .h264 container doesn't store the framerate.  To convert this to a .mp4 container for compatibility with a wide range of software:

`MP4Box -add presenting_test.h264 -fps 30 presenting_test.mp4`

For 1080p recording, I went with this:

`raspivid -o presenting_test2.h264 -t 0 -n -w 1920 -h 1080 -b 1700000 --framerate 30 --keypress`

The bitrate of 17Mbps is the highest the Raspberry Pi Foundation recommends for 1080p video, although the max is 25Mbps.

## Webcam usage
In order to use the Raspberry Pi Camera as a webcam, It seems that you need to have the driver enabled when you boot up.  Here's what I did:

```
sudo modprobe bcm2835-v4l2
sudo sed -i -e "\$asnd-bcm2835" /etc/modules
sudo sed -i -e "\$abcm2835-v4l2" /etc/modules
echo "options bcm2835-v4l2 gst_v4l2src_is_broken=1" | sudo tee /etc/modprobe.d/bcm2835-v4l2.conf
```

Taken from the [Raspberry Pi Forums](https://www.raspberrypi.org/forums/viewtopic.php?t=220261).
