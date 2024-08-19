ln -sf "$(ls -rt -d -1 "$(mpc current -f "/home/antoine/Music/%file%" | sed "s/\/[^\/]*\.\(mp3\|wma\|wav\|ogg\|m4a\)//g")"/* | grep cover | head -1)" /tmp/mpd_cover.jpg
