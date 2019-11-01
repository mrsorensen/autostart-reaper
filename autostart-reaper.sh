#!/bin/bash

# Keep going
while :
do
	# Returns whether BEHRINGER device is in lsusb
	usbresult=$(lsusb | grep BEHRINGER)
	# Runs reaper if BEHRINGER device is connected
	# and reaper is not already running
	if [[ $usbresult ]]; then
		echo "Found device"
		# Returns whether reaper is running or not
		reaperId=$(pgrep -x reaper)
		# Run reaper if reaper is not already running
		if [[ -e "$reaperId" || "$reaperId" == "" ]]; then
			echo "Reaper is not running. Starting now..."
			nohup reaper &
		else
			echo "Reaper is running"
		fi
	else
		echo "USB disconnected. Trying to kill reaper"
		killall reaper
	fi
	sleep 2
	echo "..."
done
