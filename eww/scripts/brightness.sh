#!/bin/bash

GETBRIGHTNESS () {
    BRIGHTNESSPERC=$(($(($(brightnessctl g)*100))/255))

    if [[ $BRIGHTNESSPERC -le 30 ]]; then
        BRIGHTNESSFORMATTED="󰃞 $BRIGHTNESSPERC%"
    elif [[ $BRIGHTNESSPERC -le 60 ]]; then
        BRIGHTNESSFORMATTED="󰃟 $BRIGHTNESSPERC%"
    else
        BRIGHTNESSFORMATTED="󰃠 $BRIGHTNESSPERC%"
    fi

    echo $BRIGHTNESSFORMATTED
}

dbus-monitor --system --profile "path=/org/freedesktop/systemd1/unit/sys_2ddevices_2dpci0000_3a00_2d0000_3a00_3a08_2e1_2d0000_3a05_3a00_2e0_2ddrm_2dcard1_2dcard1_5cx2deDP_5cx2d1_2damdgpu_5fbl1_2edevice,member=PropertiesChanged" | {
    while read -r _; do
        GETBRIGHTNESS
    done
}
