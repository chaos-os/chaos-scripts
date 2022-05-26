#!/bin/env bash
N=$(cat /etc/neon-os/.config/script-dependencies/web-list.txt | dmenu -p "web" -l 20)

if [[ $N == "" ]]
then
    echo "quit"
else    
    brave $N &
fi
