WINIT_X11_SCALE_FACTOR=1.666666666666667 alacritty -e tmux && wal -Ren &
sleep 1
#xdotool key super+shift+t
i3-msg move scratchpad
sleep 1
python ~/.config/i3/meta_workspaces.py -w 1
