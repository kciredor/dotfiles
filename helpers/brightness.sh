#!/bin/bash
#title           :brightness.sh
#description     :This script will help you use your brightness keys on your MacBook (tested on MacBook Pro 10.1)
#author          :Roderick Schaefer
#date            :20141102
#version         :1.0
#usage           :brightness.sh <+|->
#notes           :Use xbindkeys to bind the keys to this script. Assumes no-password sudo rights.
#bash_version    :4.3.30(1)-release
#==============================================================================

fbrightness="/sys/class/backlight/gmux_backlight/brightness"
fmaxbrightness="/sys/class/backlight/gmux_backlight/max_brightness"

if [ "$#" -ne 1 ]; then
    echo "Use '-' or '+' as param"

    exit
fi

brightness=$(head -n 1 $fbrightness)
maxbrightness=$(head -n 1 $fmaxbrightness)

if [ "+" = $1 ]; then
    brightness=$((brightness+5))

    if [ brightness >= maxbrightness ]; then
        brightness = maxbrightness
    fi
else
    brightness=$((brightness-5))

    if [ brightness <= 0 ]; then
        brightness = 0
    fi
fi

echo $brightness | sudo tee $fbrightness
