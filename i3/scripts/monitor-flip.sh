xrandr --output HDMI-1 --rotate "$1"
pkill polybar
polybar -r default &
polybar -r "monitor-$1" &
~/prog/bkgset.sh same ~/.bkg 
