brightnessctl set 0
sleep 1
declare -i ix
ix=0
while [ $ix -lt 100 ]; do
    brightnessctl set +1%
    sleep 0.01
    ((ix++))
done
