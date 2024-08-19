#!/bin/sh
# toggle-touchpad script
#
# Toggles the touchpad on and off. Bind this script to a key to turn on and off
# your touchpad/trackpad. The F7 key is a good choice on the XPS13.

# This is the version for Ubuntu MATE on the Dell XPS13 9360
# ##########################################################
# Larry Bushey
# https://goinglinux.com/articles/ToggleTrackpadTouchPad_en.htm
if [ $(xinput list-props "ELAN1201:00 04F3:30B8 Touchpad" | grep 'Device Enabled' | sed 's/\sDevice Enabled (18[01]):\s//g') -eq 0  ]; then
    xinput enable "ELAN1201:00 04F3:30B8 Touchpad"
    notify-send "Enabled" "Your computer's touchpad is enabled."
else
    xinput disable "ELAN1201:00 04F3:30B8 Touchpad"
    notify-send "Disabled" "Your computer's touchpad is disabled."
fi
