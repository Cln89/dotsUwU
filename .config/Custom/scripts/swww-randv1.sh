#!/bin/bash

# This script will randomly go through the files of a directory, setting it
# up as the wallpaper at regular intervals
#
# NOTE: this script is in bash (not posix shell), because the RANDOM variable
# we use is not defined in posix

if [[ $# -lt 1 ]] || [[ ! -d $1   ]]; then
	echo "Usage:
	$0 <dir containing images>"
	exit 1
fi

# Edit bellow to control the images transition
export SWWW_TRANSITION_FPS=75
export SWWW_TRANSITION_STEP=2

# This controls (in seconds) when to switch to the next image
INTERVAL=3000

	find "$1" -type f \
		| while read -r img; do
			echo "$((RANDOM % 1000)):$img"
		  done \
		| sort -n | cut -d':' -f2- \
		| while read -r img; do
			swww img "$img" --transition-duration 1 -t grow
			exit 1;
		  done
		  exit 1;
