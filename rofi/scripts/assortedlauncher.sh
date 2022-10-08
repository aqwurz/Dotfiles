#!/bin/bash

rofi_command="rofi -theme themes/powermenu.rasi -show-icons -icon-theme Paper"

### Options ###
ripcord=""
thunderbird=""
firefox=""
atom=""
# Variable passed to rofi
options="$ripcord\n$thunderbird\n$firefox\n$atom"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $ripcord)
        ripcord
        ;;
    $thunderbird)
        thunderbird
        ;;
    $firefox)
	firefox --new-instance
        ;;
    $atom)
        atom
        ;;
    #$steam)
    #    steam
    #    ;;
esac

