target="2024-05-15 12:00"
x=$(date -d "${target}" "+%s")
y=$(date +%s)
if [[ $((x-y)) -gt 86400 ]]; then
    date -ud @$(echo $(( x - y - 86400 ))) "+%d:%T"
else
    date -ud @$(echo $(( x - y ))) "+%T"
fi
