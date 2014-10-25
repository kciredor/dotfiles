# xrandr --output eDP-1 --scale .8x.8
# xrandr --output DP-1 --mode 1920x1080 --right-of eDP-1
xrandr --output DP-2 --scale .5729x.5729
xset r rate 170 70
xset m 1 0
setxkbmap dvorak -option caps:swapescape
xmodmap ~/.Xmodmap
exec awesome
