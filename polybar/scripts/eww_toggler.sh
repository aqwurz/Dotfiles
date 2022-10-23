if [[ $(cat ~/.eww_tasks_open) == "0" ]]; then
    eww open tasks$1
    echo "1" > .eww_tasks_open
else
    eww close tasks$1
    echo "0" > .eww_tasks_open
    ~/.config/eww/scripts/calsync.sh
fi
