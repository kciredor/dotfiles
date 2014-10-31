xrandr --output DP-1 --mode 1920x1080 --right-of eDP-1

xset s off         # Don't activate screensaver.
xset -dpms         # Disable Energy Star features.
xset s noexpose    # Disallow window exposure.
xset s noblank     # Don't blank the video device.
xset r rate 170 70 # Fast keyboard repeat.

setxkbmap dvorak -option caps:swapescape
xmodmap ~/.Xmodmap
exec awesome
