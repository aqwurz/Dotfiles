WINIT_X11_SCALE_FACTOR=1.666666666666667 alacritty && wal -Ren &
sleep 1
#xdotool key super+shift+t
swaymsg move scratchpad
sleep 1
python ~/.config/sway/meta_workspaces.py -w 1
