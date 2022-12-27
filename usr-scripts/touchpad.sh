#!/bin/env bash

CURR_STATE=$(xinput --list-props 14 | grep 'Device Enabled' | rev | cut -c 1)
NEW_STATE=$((1 - $CURR_STATE))

xinput set-prop 14 "Device Enabled" $NEW_STATE
