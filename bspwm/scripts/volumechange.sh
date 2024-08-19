# TODO: Refactor this shit plz


if [[ $1 == "up" ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ +5%
fi
if [[ $1 == "down" ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ -5% 
fi
if [[ $1 == "mute" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle 
fi

if [[ $(pactl list sinks | awk '/Mute/ { print $2 }' | tail -n 1) == "yes" ]]; then
    #echo "$(pactl list sinks | grep '^[[:space:]]Volume:' | \
    #    head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')!" >> /tmp/xobpipe
    echo $(pactl list sinks | grep '[[:space:]]Volume:' | tail -n 2 | grep -P -o "\d{1,3}%" | head -n 1 | tr -d %)! >> /tmp/xobpipe
fi
if [[ $(pactl list sinks | awk '/Mute/ { print $2 }' | tail -n 1) == "no" ]]; then
    #echo "$(pactl list sinks | grep '^[[:space:]]Volume:' | \
    #    head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')" >> /tmp/xobpipe
    pactl list sinks | grep '[[:space:]]Volume:' | tail -n 2 | grep -P -o "\d{1,3}%" | head -n 1 | tr -d % >> /tmp/xobpipe
fi
