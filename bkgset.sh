if [[ -L $2 ]] || [[ -f $2 ]]; then
    if [[ $1 == "dark" ]] || [[ $1 == "same" && $(cat ~/.bkgtheme) == "dark" ]]; then
        echo "dark" > ~/.bkgtheme
        wal -c
        wal -i "$2" --backend wal -a 70
        sed -i 's/f0f0f0/000000/g' ~/.config/alacritty/alacritty.yml
        sed -i 's/f0f0f0/000000/g' ~/.config/dunst/dunstrc
    elif [[ $1 == "light" ]] || [[ $1 == "same" && $(cat ~/.bkgtheme) == "light" ]]; then
        echo "light" > ~/.bkgtheme
        wal -c
        wal -i "$2" --backend wal -l -a 70
        sed -i 's/000000/f0f0f0/g' ~/.config/alacritty/alacritty.yml
        sed -i 's/000000/f0f0f0/g' ~/.config/dunst/dunstrc
    else
        echo "invalid argument specified"
        exit 1
    fi
    pkill xob
    pywalfox update
    g815-led -p ~/.cache/wal/g815profile1
    oomox-cli /opt/oomox/scripted_colors/xresources/xresources-reverse
    tail -f /tmp/xobpipe | xob -c ~/.cache/wal/xob.cfg > /dev/null &
    #fc-cache -f
    #polybar-msg cmd restart
    pkill dunst
    eww kill
    sed -i "s/\".*\" # sed bg/\"$(cat ~/.cache/wal/colors | head -1)\" # sed bg/g" ~/.config/dunst/dunstrc
    sed -i "s/\".*\" # sed fg low/\"$(cat ~/.cache/wal/colors | head -7 | tail -1)\" # sed fg low/g" ~/.config/dunst/dunstrc
    sed -i "s/\".*\" # sed fg normal/\"$(cat ~/.cache/wal/colors | head -8 | tail -1)\" # sed fg normal/g" ~/.config/dunst/dunstrc
    eww daemon
    dunst &
    betterlockscreen -u ~/.bkg
    if [[ -L $2 ]]; then
        echo "not updating symlink"
    else
        echo "updating symlink"
        BKG=$2
        ln -sf "$2" ~/.bkg
    fi
elif [[ $1 == "help" ]] || [[ $1 == "-h" ]] || [[ $1 == "--help" ]]; then
cat << EOT
Usage:
    bkgset dark|light|same IMAGE
    bkgset help
    bkgset -h|--help

Options:
    help:   Prints a help message.
    dark:   Sets the global colour scheme to a dark variant based on IMAGE.
    light:  Sets the global colour scheme to a light variant based on IMAGE.
    same:   Sets the global colour scheme to the variant last used, based
            on IMAGE.
EOT
exit 0
else
    echo "invalid file specified"
    exit 2
fi 
