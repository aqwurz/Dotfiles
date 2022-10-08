# TODO: Refactor this shit plz


if [[ $1 == "up" ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ +5% && killall -SIGUSR1 i3status
fi
if [[ $1 == "down" ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ -5% && killall -SIGUSR1 i3status
fi
if [[ $1 == "mute" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle && killall -SIGUSR1 i3status
fi

if [[ $(pactl list sinks | awk '/Mute/ { print $2 }') == "yes" ]]; then
    echo "$(pactl list sinks | grep '^[[:space:]]Volume:' | \
        head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')!" >> /tmp/xobpipe
fi
if [[ $(pactl list sinks | awk '/Mute/ { print $2 }') == "no" ]]; then
    echo "$(pactl list sinks | grep '^[[:space:]]Volume:' | \
        head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')" >> /tmp/xobpipe
fi
