#!/bin/bash

SHOW_WARNING=0

RENMARIGAYSEX () {
    BATPERC=$(cat /sys/class/power_supply/BAT0/capacity)
    BATSTAT=$(cat /sys/class/power_supply/BAT0/status)

    if [ "$BATSTAT" == "Charging" ]; then
        BATFORMATTED="󰂄 $BATPERC%"
        SHOW_WARNING=0
    else
        if [[ BATPERC -le 15 ]]; then
            BATFORMATTED="󰂃 $BATPERC%"
            if [[ SHOW_WARNING -ge 5 ]]; then
                notify-send -t 5000 "Low battery" "Please charge"
                SHOW_WARNING=0
            else
                SHOW_WARNING=$((SHOW_WARNING+1))
            fi
        elif [[ BATPERC -le 20 ]]; then
            BATFORMATTED="󰁻 $BATPERC%"
        elif [[ BATPERC -le 30 ]]; then
            BATFORMATTED="󰁼 $BATPERC%"
        elif [[ BATPERC -le 40 ]]; then
            BATFORMATTED="󰁽 $BATPERC%"
        elif [[ BATPERC -le 50 ]]; then
            BATFORMATTED="󰁾 $BATPERC%"
        elif [[ BATPERC -le 60 ]]; then
            BATFORMATTED="󰁿 $BATPERC%"
        elif [[ BATPERC -le 70 ]]; then
            BATFORMATTED="󰂀 $BATPERC%"
        elif [[ BATPERC -le 80 ]]; then
            BATFORMATTED="󰂁 $BATPERC%"
        elif [[ BATPERC -le 90 ]]; then
            BATFORMATTED="󰂂 $BATPERC%"
        elif [[ BATPERC -le 100 ]]; then
            BATFORMATTED="󰁹 $BATPERC%"
        fi
    fi

    echo $BATFORMATTED
}

LASTMSGTIMESTAMP=""
dbus-monitor --system --profile "path=/org/freedesktop/UPower/devices/battery_BAT0,member=PropertiesChanged" | {
    while read -r LASTMSG; do
        TIMESTAMP=${LASTMSG:0:14}
        # echo "current: $TIMESTAMP"
        # echo "last: $LASTMSGTIMESTAMP"
        if [[ "$LASTMSGTIMESTAMP" == "$TIMESTAMP" ]] then
            # echo "found repeat timestamp"
            true # just to hide comment
        else
            LASTMSGTIMESTAMP=$TIMESTAMP
            # echo "setting to $LASTMSGTIMESTAMP"
            RENMARIGAYSEX
        fi
    done
}
