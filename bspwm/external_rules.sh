#!/bin/sh

# set states for several programs
bspc rule -a mpv state=floating
bspc rule -a feh state=floating
bspc rule -a nmtui state=floating
bspc rule -a matplotlib state=floating
bspc rule -a Music state=floating
bspc rule -a *:Picture-in-Picture:* state=floating
bspc rule -a *:*:"Picture in picture" state=floating

# set workspaces and states for selected programs
bspc rule -a zoom desktop='0' state=floating follow=on
bspc rule -a Slack desktop='5' follow=off
bspc rule -a FreeTube desktop='7' follow=on
bspc rule -a discord desktop='9' follow=off
bspc rule -a minecraft desktop='2'

# stolen wholesale from https://github.com/SwiftyChicken/dotfiles/,
# adapted to my needs

wid=$1
class=$2
title=$(xprop WM_NAME -id $wid | sed 's/WM_NAME(STRING) = "\(.*\)"/\1/g')
instance=$3

if [ "$title" = "nmtui" ]; then
    xdotool windowmove $wid 582 276
    xdotool windowsize $wid 659 548
fi
if [ "$title" = "iwgtk" ]; then
    xdotool windowmove $wid 2860 50 
fi
