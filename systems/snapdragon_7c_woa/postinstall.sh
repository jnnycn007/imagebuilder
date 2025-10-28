#!/bin/bash

cp -v etc/X11/xorg.conf.d.samples/11-fbdev.conf etc/X11/xorg.conf.d
# later after installing the firmware files from windows, this is used instead
#cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d
# workaround for the keyboard not working
# see: https://github.com/velvet-os/imagebuilder/issues/136#issuecomment-3448921421
# and: https://github.com/velvet-os/imagebuilder/discussions/320#discussioncomment-14762677
cp -v etc/X11/xorg.conf.d.samples/51-kbd-via-evdev-input.conf etc/X11/xorg.conf.d
