#!/bin/bash

# install the qcom tools qrtr-ns and rmtfs
apt-get -y install protection-domain-mapper qrtr-tools rmtfs tqftpserv

# workaround for the keyboard not working
# see: https://github.com/velvet-os/imagebuilder/issues/136#issuecomment-3448921421
# and: https://github.com/velvet-os/imagebuilder/discussions/320#discussioncomment-14762677
apt-get -y install xserver-xorg-input-evdev
