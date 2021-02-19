#!/bin/bash
while true
do
	STATUS_MONITOR=$(xset -display :0  q | grep "Monitor is" | awk '{print $3}')
	if [ "$STATUS_MONITOR" == "Off" ]; then
		motion &>/dev/null &
		inotifywait -m .motion -e create -e moved_to |  
			while read dir action file; do 
	    			xset -display :0 dpms force on
				killall motion
				killall inotifywait 
    		done
	fi
	sleep 1
done

