#!/bin/env bash

# Please fail on hidden bugs
set -euo pipefail

N=$(cat /etc/neon-os/.config/script-dependencies/web-list.txt | dmenu -p "web" -l 20)

case $N in
    "")
	echo "quit";;
    *)    
	xdg-open $N &;;
esac
