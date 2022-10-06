. "/home/antoine/.cache/wal/colors.sh"

color='00000080'
foreground='ffffffff'
blur=-10
indpos='1860:1020'
timepos='50:1000'
greet="$(fortune -s)"
greetpos='50:100'
verif="hmm"
wrong="no"
radius=30
ringw=5
align=0
datepos='tx:ty+20'

#betterlockscreen -l -- -B=$blur --force-clock --keylayout 2 --indicator --inside-color $color --insidever-color $color --date-str="%Y-%m-%d" --ind-pos=$indpos --time-pos=$timepos --date-color $foreground --time-color $foreground --layout-color $foreground --greeter-text="$greet" --greeter-pos=$greetpos --greeter-color=$foreground --wrong-text=$wrong --radius $radius --ring-width $ringw --time-align $align --date-pos=$datepos --date-align $align --layout-align $align --greeter-align $align --pass-screen-keys --pass-media-keys

betterlockscreen -l -- --ring-color $(echo $color7 | sed 's/#//g')FF --keyhl-color $(echo $color3 | sed 's/#//g')FF --ringver-color $(echo $color2 | sed 's/#//g')FF --ringwrong-color FF8080FF --greeter-text "$(python .config/polybar/scripts/date.py | sed 's/|.*//g')" --greeter-size 13 --verif-text=$verif --wrong-text=$wrong --ignore-empty-password --verif-align=$align --wrong-align=$align --verif-pos="ix:iy+1" --wrong-pos="ix:iy+1" --wrong-color 00000000
