echo 1 > ~/.bspwm_inplace
[[ $(cat ~/.bspwm_inplace) == 1 ]] && bspc wm -r
dunstify "BSPWM" "bspwm reloaded"
echo 0 > ~/.bspwm_inplace
