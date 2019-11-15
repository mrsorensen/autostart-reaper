#!/bin/bash

source ~/colors.sh


# Keep going
while :
do
	# Returns whether BEHRINGER device is in lsusb
	usbresult=$(lsusb | grep BEHRINGER)
	# Runs reaper if BEHRINGER device is connected
	# and reaper is not already running
	if [[ $usbresult ]]; then
		printf "${GREEN}Found device${NC}\n"
		# Returns whether reaper is running or not
		reaperId=$(pgrep -x reaper)
		# Run reaper if reaper is not already running
		if [[ -e "$reaperId" || "$reaperId" == "" ]]; then
			printf "${RED}Reaper{NC} is not running. ${GREEN}Starting now...${NC}\n"
			nohup reaper &
		else
			echo "Reaper is running"
		fi
	else
		printf "\r${RED}USB device not connected. ${NC}"
		if [[ $(pgrep reaper | wc -l) == 2 ]]; then
			printf "Killing ${PURPLE}REAPER${NC}"
			killall reaper
		fi
	fi
	sleep 2
done
