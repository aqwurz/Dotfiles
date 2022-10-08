#!/bin/sh

URL="https://www.reddit.com/message/unread/.json?feed=a74c1ee93e7ef6c5d459bb38d7156e75435bfbf4&user=AntazarOfQwurz"
USERAGENT="polybar-scripts/notification-reddit:v1.0 u/AntazarOfQwurz"

notifications=$(curl -sf --user-agent "$USERAGENT" "$URL" | jq '.["data"]["children"] | length')

if [ -n "$notifications" ] && [ "$notifications" -gt 0 ]; then
    echo " $notifications"
else
    echo ""
fi
