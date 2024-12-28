#!/bin/bash

VOLPERC=$(amixer get Master | awk -F"[][]" '/Left:/ { print $2 }' | sed 's/.\{1\}$//')
VOLSTATUS=$(amixer get Master | awk -F"[][]" '/Left:/ { print $4 }')

if [ "$VOLSTATUS" = "on" ]; then

    if [[ VOLPERC -eq 0 ]]; then
        VOLFORMATTED="󰝟 $VOLPERC%"
    elif [[ VOLPERC -le 30 ]]; then
        VOLFORMATTED="󰕿 $VOLPERC%"
    elif [[ VOLPERC -le 60 ]]; then
        VOLFORMATTED="󰖀 $VOLPERC%"
    else
        VOLFORMATTED="󰕾 $VOLPERC%"
    fi

else
    VOLFORMATTED="󰝟 $VOLPERC%"
fi

echo $VOLFORMATTED
