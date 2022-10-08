if [[ $2 == "up" ]]; then
    echo "$((${1:0:-2} - 1))"
elif [[ $2 == "down" ]]; then
    echo "$((${1:0:-2} + 1))"
fi
