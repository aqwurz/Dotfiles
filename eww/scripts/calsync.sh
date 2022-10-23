vdirsyncer sync
rm ~/.calcurse/apts
for f in ~/.config/vdir/calendars/*/*.ics; do
    calcurse -i "$f";
done
