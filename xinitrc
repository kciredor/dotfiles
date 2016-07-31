xset s off         # Don't activate screensaver.
xset -dpms         # Disable Energy Star features.
xset s noexpose    # Disallow window exposure.
xset s noblank     # Don't blank the video device.
xset r rate 170 70 # Fast keyboard repeat.

setxkbmap dvorak -option caps:swapescape
xmodmap ~/.Xmodmap
xbindkeys

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

nm-applet &
hp-systray &

exec awesome
