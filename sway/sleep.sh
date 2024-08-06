#!/bin/bash

BATSTAT=$(cat /sys/class/power_supply/BAT0/status)

if [ "$BATSTAT" == "Discharging" ]; then
    systemctl suspend
fi
