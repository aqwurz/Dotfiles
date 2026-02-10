#!/bin/sh
if [ -n "$(cat /var/run/user/$(id -u)/my_screen_saver.pid)" ]; then
    kill $(cat /var/run/user/$(id -u)/my_screen_saver.pid); \
    echo "" > /var/run/user/$(id -u)/my_screen_saver.pid
fi
