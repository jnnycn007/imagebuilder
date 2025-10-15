#!/bin/bash

# some corsola devices created strange audio noises when run with
# pulseaudio which were not there when run with pipewire, so lets
# switch this device to pipewire by default ...
apt-get -y install pipewire-audio
