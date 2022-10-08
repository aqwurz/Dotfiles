color='00000080'
foreground='ffffffff'
blur=-10
indpos='1860:1020'
timepos='50:1000'
greet="$(fortune -s)"
greetpos='50:100'
wrong="Rejected!"
radius=30
ringw=5
align=1
datepos='tx:ty+20'

i3lock -B=$blur --force-clock --keylayout 2 --indicator --insidecolor $color --insidevercolor $color --datestr="%Y-%m-%d" --indpos=$indpos --timepos=$timepos --datecolor $foreground --timecolor $foreground --layoutcolor $foreground --greetertext="$greet" --greeterpos=$greetpos --greetercolor=$foreground --wrongtext=$wrong --radius $radius --ring-width $ringw --time-align $align --datepos=$datepos --date-align $align --layout-align $align --greeter-align $align --pass-screen-keys --pass-media-keys
