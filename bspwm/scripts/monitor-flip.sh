autorandr -l horizontal
xrandr --output HDMI-1 --rotate "$1"
pkill polybar
echo 1 > ~/.bspwm_inplace
bspc wm -r && dunstify "BSPWM" "bspwm reloaded"
echo 0 > ~/.bspwm_inplace
polybar -r default &
polybar -r "monitor-$1" &
~/prog/bkgset.sh same ~/.bkg 
