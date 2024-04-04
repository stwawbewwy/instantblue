#!/bin/bash

playerctl metadata --player cmus --format 'Now Playing - {{title}}' --follow | {
    while read -r NOWPLAYING; do
        echo $NOWPLAYING
    done
}

echo $MUSICSTATUS
