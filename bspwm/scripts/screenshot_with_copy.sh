_filename=$(date --iso-8601=seconds | sed 's/:/-/g' | sed 's/T/_/g' | cut -c -19)
scrot "x.png" -e 'mv $f ~/screenshots/MOVE_ME.png' -s -f 
mv ~/screenshots/MOVE_ME.png "/home/antoine/screenshots/$(echo $_filename)_cropped.png"
xclip -i "/home/antoine/screenshots/$(echo $_filename)_cropped.png" -selection clipboard -t image/png
