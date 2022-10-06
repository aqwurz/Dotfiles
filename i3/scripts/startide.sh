# sed -i "s//\n/g" ~/.config/nnn/.selection
cp ~/.config/nnn/.selection ~/.config/i3/idefile
tmux split-window -h 'xargs -0 vim -p < "${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.selection"'
tmux split-window -h -c "$(sed 's/\/[^\/]*$//' ~/.config/i3/idefile | sed 's/^.*\/home/\/home/')"
tmux split-window -h 'tty-clock -c'
tmux select-layout "$(cat ~/.config/i3/idelayout)"
tmux select-pane -L
tmux select-pane -U
rm ~/.config/i3/idefile
