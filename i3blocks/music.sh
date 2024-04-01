#!/bin/bash

MUSICSTATUS=$(playerctl --player=cmus metadata title)

echo $MUSICSTATUS
