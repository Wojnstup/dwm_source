#!/bin/bash
nitrogen --restore &
setxkbmap pl &
picom -b &

while : ; do
        MEM=$(echo Ram:$(free -m | grep Mem | awk '{ print $3"M/"$2"M" }'))
        xsetroot -name "$MEM $(date +"%H:%M %A")"
        sleep 2
done &


exec dwm
