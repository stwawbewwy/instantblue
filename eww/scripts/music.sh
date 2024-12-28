#!/bin/bash

GETMUSIC () {
    MUSICSTATE=$(mpc status [%state%])
    CURRENTMUSIC=$(mpc current -f "[%title%]")
    if [[ "$MUSICSTATE" == "playing" ]]; then
        MUSICFORMATTED="󰐊 $CURRENTMUSIC"
    elif [[ "$MUSICSTATE" == "paused" ]]; then
        MUSICFORMATTED="󰏤 $CURRENTMUSIC"
    elif [[ "$MUSICSTATE" == "stopped" ]]; then
        MUSICFORMATTED="󰓛 No Music"
    fi
    echo $MUSICFORMATTED
}

GETMUSIC
mpc idleloop player | {
    while read -r _; do
        GETMUSIC
    done
}
