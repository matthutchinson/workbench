#!/bin/bash

# Clears finished downloads from Transmission.
# Version: 1.1
#
# Newest version can always be found at:
# https://gist.github.com/pawelszydlo/e2e1fc424f2c9d306f3a

SERVER="host:port --auth user:password"
TRANSMISSION_REMOTE="/volume1/@appstore/transmission/bin/transmission-remote"

# Which torrent states should be removed at 100% progress.
DONE_STATES=("Seeding" "Stopped" "Finished" "Idle")

#echo "Attempting to remove done torrents from: ${SERVER: : 10}(...)"  # Truncate to not print auth.

# Use transmission-remote to get the torrent list from transmission-remote.
TORRENT_LIST=$($TRANSMISSION_REMOTE $SERVER --list | sed -e '1d' -e '$d' | awk '{print $1}' | sed -e 's/[^0-9]*//g')

# Iterate through the torrents.
for TORRENT_ID in $TORRENT_LIST
	do
	  INFO=$($TRANSMISSION_REMOTE $SERVER --torrent "$TORRENT_ID" --info)
	  #echo -e "Processing #$TORRENT_ID: \"$(echo "$INFO" | sed -n 's/.*Name: \(.*\)/\1/p')\"..."
	  # To see the full torrent info, uncomment the following line.
	  #echo "$INFO"
	  PROGRESS=$(echo "$INFO" | sed -n 's/.*Percent Done: \(.*\)%.*/\1/p')
	  STATE=$(echo "$INFO" | sed -n 's/.*State: \(.*\)/\1/p')

	# If the torrent is 100% done and the state is one of the done states.
	if [[ "$PROGRESS" == "100" ]] && [[ "${DONE_STATES[@]}" =~ "$STATE" ]]; then
	  echo "Torrent #$TORRENT_ID is done. Removing torrent from list."
	  $TRANSMISSION_REMOTE $SERVER --torrent "$TORRENT_ID" --remove
	#else
	  #echo "Torrent #$TORRENT_ID is $PROGRESS% done with state \"$STATE\". Ignoring."
	fi
done
