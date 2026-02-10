#!/usr/bin/env sh
#
# A rofi powered menu to execute power related action.

power_off=''
reboot=''
lock=''
suspend='鈴'
log_out=''

chosen=$(printf '%s;%s;%s;%s;%s\n' "$power_off" "$reboot" "$lock" "$suspend" \
                                   "$log_out" \
    | rofi -theme 'themes/power.rasi' \
           -dmenu \
           -sep ';' \
           -selected-row 2)

case "$chosen" in
    "$power_off")
        [[ $(pactl list sinks | awk '/Mute/ { print $2 }') == "no" ]] && pkill polybar && pkill alacritty && mpv ~/.config/i3/shutdown.mp3 
        systemctl poweroff
        ;;
    "$reboot")
        [[ $(pactl list sinks | awk '/Mute/ { print $2 }') == "no" ]] && pkill polybar && pkill alacritty && mpv ~/.config/i3/shutdown.mp3 
        systemctl reboot
        ;;
    "$lock")
        #i3lock -B=1000 -k --keylayout 2 --indicator --insidecolor ffffffff --insidevercolor ffffffff --datestr="%Y-%m-%d"
        #xscreensaver-command -lock
        #physlock -p "$(figlet -cf slant antoine | lolcat; echo "$(fortune -s | figlet -cf term)")"
        swaylock -i ~/.bkg -s fill -l -e --indicator --inside-color 00000080 --inside-ver-color 20202080 --inside-wrong-color 20000080 --ring-color FFFFFF00 --ring-ver-color 808080FF --ring-wrong-color FF0000FF --key-hl-color 00FF00FF --bs-hl-color 008000FF --line-color 00000000 --separator-color 00000000 --clock --timestr '%H:%M:%S' --datestr '%Y-%m-%d' --grace 5 --text-ver hmm --text-wrong no
        ;;
    "$suspend")
        mpc -q pause
        amixer set Master mute
        systemctl suspend
        ;;
    "$log_out")
        swaymsg exit &
        niri msg action quit &
        pkill bspwm &
        ;;
    *) exit 1 ;;
esac

