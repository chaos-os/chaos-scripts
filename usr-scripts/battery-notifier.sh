#!/bin/env bash

# Please fail on hidden bugs
set -euo pipefail

if [[ $(acpi | grep 'Battery') == '' ]]; then
	exit
fi

while :; do
	N=$(acpi | cut -d ' ' -f4 | cut -d ',' -f1 | cut -d '%' -f1)
	M=$(acpi | cut -d ' ' -f3 | cut -d ',' -f1)
	if [[ $N -le "30" && $M != "Charging" ]]; then
		dunstify "please plug in your charger" -u "critical"
	elif [[ $N -ge "85" && $M == "Charging" ]]; then
		dunstify "please plug out your charger" -u "low"
	fi
	sleep 60
done
