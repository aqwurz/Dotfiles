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
        physlock -p "$(figlet -cf slant antoine | lolcat; echo "$(fortune -s | figlet -cf term)")"
        ;;
    "$suspend")
        mpc -q pause
        amixer set Master mute
        systemctl suspend
        ;;
    "$log_out")
        swaymsg exit &
        pkill bspwm &
        ;;
    *) exit 1 ;;
esac

