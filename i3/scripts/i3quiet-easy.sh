#!/bin/bash

originalworkspace=01
if ["$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d'"' -f2)" == 99]; then
	conky -c ~/.config/conky/bottombar
	i3-msg move container to workspace $originalworkspace
	i3-msg workspace $originalworkspace
	i3-msg floating toggle
	polybar-msg cmd show
else
	originalworkspace="$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d'"' -f2)"
	pkill conky
	i3-msg move container to workspace 99
	i3-msg workspace 99
	i3-msg floating toggle
	polybar-msg cmd hide
fi
