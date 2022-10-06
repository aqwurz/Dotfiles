#!/bin/sh
# toggle-mic script
#
# Toggles the microphone on and off. Bind this script to a key to turn on and 
# off your microphone. 

if [ "$(cat ~/.micmute)" -eq "1" ]; then
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
    echo 0 > ~/.micmute
    notify-send "Disabled" "Your computer's microphone is disabled."
else
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
    echo 1 > ~/.micmute
    notify-send "Enabled" "Your computer's microphone is enabled."
fi
