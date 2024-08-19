#!/usr/bin/env bash

bspc subscribe node_add node_remove node_state node_transfer node_flag desktop_focus | while read line
do
    num_wins=$(bspc query -N -d focused -n .window.tiled.\!hidden | wc -l)
    if [[ $num_wins -eq 0 || $num_wins -eq 1 ]]; then
        bspc config left_padding 1000
        bspc config right_padding 1000
        bspc config left_monocle_padding -1000
        bspc config right_monocle_padding -1000
    elif [[ $num_wins -eq 2 ]]; then
        bspc config left_padding 290
        bspc config right_padding 290
        bspc config left_monocle_padding -290
        bspc config right_monocle_padding -290
    elif [[ $num_wins -ge 3 ]]; then
        bspc config left_padding 0
        bspc config right_padding 0
        bspc config left_monocle_padding 0
        bspc config right_monocle_padding 0
    fi
    if [[ $num_wins -le 3 ]]; then
        bspc node @/ --balance
    fi
done
