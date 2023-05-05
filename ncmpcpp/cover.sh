ln -sf "$(ls -rt -d -1 "$(mpc current -f "/home/antoine/Music/%file%" | sed "s/\/[^\/]*\.mp3//g")"/* | grep cover)" /tmp/mpd_cover.jpg
