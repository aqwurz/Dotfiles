if [[ $(mpc current) == "" ]]; then
    echo ~/.face
else
    echo /tmp/mpd_cover.jpg
fi 
