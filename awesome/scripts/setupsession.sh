#!/bin/bash

touchpad="$(xinput list --name-only | grep -i touchpad)"
if [ ! -z "$touchpad" ]; then
    xinput set-prop "$touchpad" "libinput Tapping Enabled" 1
    xinput set-prop "$touchpad" "libinput Natural Scrolling Enabled" 1
fi

