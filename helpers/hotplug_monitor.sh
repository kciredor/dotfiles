#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/kciredor/.Xauthority
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus


function connect()
{
  xset r rate 170 70
  setxkbmap dvorak -option caps:swapescape
  xmodmap ~/.Xmodmap
}

function disconnect(){
  xrandr --output eDP-1 --mode 1920x1200
  xrandr --output DP-1 --off
  xrandr --output DP-2 --off
}


if [ $(cat /sys/class/drm/card0-DP-2/status) == "connected" ] ; then
  xrandr --output DP-2 --mode 3440x1440 --right-of eDP-1
  xrandr --output eDP-1 --off

  connect
elif [ $(cat /sys/class/drm/card0-DP-1/status) == "connected" ] ; then
  xrandr --output DP-1 --mode 1920x1080 --right-of eDP-1

  connect
else
  disconnect
fi
