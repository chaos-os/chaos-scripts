#!/bin/env bash

# Please fail on hidden bugs
set -euo pipefail

zenity --warning --text="DISCLAMER!!! \n Use the article for personal use only.\n Any illegal Activities shall not be held responsible by the developer" --ellipsize

cmd=$(zenity --entry --text="enter any article url to download and convert for later viewing: " --width=1000)

mkdir_on_fail() {
	cd ~
	mkdir -p rest/articles
	cd articles
}

fail_err() {
	echo "ERROR: Failed to mkdir."
	exit
}

case $cmd in
"")
	exit
	;;
*)
	cd ~/rest/articles || mkdir_on_fail || fail_err
	aria2c -Umozilla/5.0 -x 10 -c $cmd
	ls | zenity --text="all files in article directory" --list --column="files" &
	Name=$(zenity --entry --text="enter unique name for your article: " --width=100)
	pandoc *.html -o "${Name}.docx"
	pandoc *.php -o "${Name}.docx"
	rm *.html
	rm *.php
	killall zenity
	dunstify "Finished downloading!!" -u "normal"
	;;
esac
