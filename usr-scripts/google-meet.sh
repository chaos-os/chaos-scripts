#!/usr/bin/env bash

# Please fail on hidden bugs
set -euo pipefail

gm="https://meet.google.com"

VAR1=$(printf '%s\n' "DAA" "DMS" "SS L/TH" "SS TUT" "WT TH" "WT L" "WT TUT" "New Meet"| dmenu -i -l 10 -p 'Google meet')

case "$VAR1" in
    "DAA")
	xdg-open $gm/"pse-gyeq-bds";;
    "DMS")
	xdg-open $gm/"apr-ijmy-vni";;
    "SS L/TH")
	xdg-open $gm/"pyn-mxzy-hqo";;
    "SS TUT")
	xdg-open $gm/"ben-ovsi-rkm";;
    "WT TH")
	xdg-open $gm/"bxd-gvjn-cea";;
    "WT L")
	xdg-open $gm/"vps-tifb-yhk";;
    "WT TUT")
	xdg-open $gm/"ben-ovsi-rkm";;
    "New Meet")
	VAR=$(echo ''| dmenu -p "Code: ")
	xdg-open $gm/$VAR;;
    *)
	echo "quit";;
esac
