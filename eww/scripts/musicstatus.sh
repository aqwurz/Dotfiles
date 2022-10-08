if [[ $1 == "artist" ]]; then
    if [[ $(mpc current) == "" ]]; then
        echo "Nothing is playing"
    else
        echo $(mpc current -f "%artist%")
    fi
elif [[ $1 == "title" ]]; then
    if [[ $(mpc current) == "" ]]; then
        echo "Open ncmpcpp to play..."
    else
        echo $(mpc current -f "%title%")
    fi
fi

