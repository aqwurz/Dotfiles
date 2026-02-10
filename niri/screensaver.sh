#!/bin/sh
# init part
PID=""
niri_id=""
ss_address=""
screen_saver=""
SCREEN_SAVERS_DIR=/usr/lib/xscreensaver
USR_RUN_DIR=/var/run/user/$(id -u)
if [ ! -r "$USR_RUN_DIR/my_screen_saver.pid" ]; then
    echo "" > $USR_RUN_DIR/my_screen_saver.pid
fi
# Functions
exec_screen_saver(){
    if [ -z "$(cat $USR_RUN_DIR/my_screen_saver.pid)" ]; then
        screen_saver=$(cat $HOME/.config/niri/screensaver_list | shuf -n 1)
        $SCREEN_SAVERS_DIR/$screen_saver &
        PID=$!
        echo $PID > $USR_RUN_DIR/my_screen_saver.pid # to always have a pid to kill.
    fi
}
get_hypr_address(){
    local query=".[] | select(.pid == $1) | .address"
    sc_address=$(hyprctl clients -j | jq -r "$query")
}
# In a graphical session?
if [ -z "$DESKTOP_SESSION" ]; then
    echo "Not in Sway or Hyprland! nothing to do."
elif [ "$DESKTOP_SESSION" = "sway" ]; then
    exec_screen_saver
    sleep 1
    if [ -z "$screen_saver" ]; then
        echo ""
    else
        swaymsg -- \[instance=$screen_saver\] fullscreen enable
    fi
elif [ "$DESKTOP_SESSION" = "hyprland" ]; then
    exec_screen_saver
    sleep 1
    if [ -z "$screen_saver" ]; then
        echo ""
    else
        get_hypr_address $PID
        hyprctl dispatch focuswindow "address:$sc_address"
        hyprctl dispatch fullscreen x
    fi
elif [ "$DESKTOP_SESSION" = "niri" ]; then
    exec_screen_saver
    sleep 1
    niri_id=$(niri msg windows | grep -B 1 xscreensaver | grep -o -E "[0-9]+" | head -1)
    if [ -z "$screen_saver" ]; then
        echo ""
    else
        niri msg action fullscreen-window --id $niri_id
    fi
else
    echo "Not implemented yet..."
fi
