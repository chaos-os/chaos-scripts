#!/bin/env bash

# Please fail on hidden bugs
set -euo pipefail

launch=`/usr/bin/ls ~/.var/app/ | dmenu -l 20 -i -p "flatpak run:"`
flatpak run $launch &
