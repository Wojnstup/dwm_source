#!/bin/bash
nitrogen --restore &
setxkbmap pl &
picom -b &

 Status bar
{
	UPDATES=$( pacman -Qu | wc -l)

	if (( $UPDATES == 0 )); then
	        UPDATES=""
	else
	        UPDATES="[Updates: $UPDATES] "
	fi

	while : ; do
		CPU=$( echo CPU:$( grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage }' | awk -F. '{print $1"."substr($2,1,2)"%"}' ) )
		MEM=$( echo Ram:$(free -m | grep Mem | awk '{ print $3"M/"$2"M" }'))
		NET=$( echo Net:$( ifstat | grep eno1 | awk '{ print $6" ⇵ "$8 }' ) )
		VOL=$( echo Vol:$( amixer -c 0 get Master | grep "Mono: Playback" | awk -F[ '{ print $2 }' | sed 's/]//g'))
		xsetroot -name " $UPDATES[$VOL] [$MEM] [$NET] [$CPU] $(date +"%H:%M %A")"
		sleep 2
	done 
} &

exec dwm
