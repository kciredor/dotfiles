xrandr --output DP-1 --mode 1920x1080 --right-of eDP-1
# xrandr --output DP-2 --mode 1280x1024 --right-of DP-1

xset s off         # Don't activate screensaver.
xset -dpms         # Disable Energy Star features.
xset s noexpose    # Disallow window exposure.
xset s noblank     # Don't blank the video device.
xset r rate 170 70 # Fast keyboard repeat.

setxkbmap dvorak -option caps:swapescape
xmodmap ~/.Xmodmap
xbindkeys

sudo tee /sys/class/leds/smc::kbd_backlight/brightness <<< 200

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

exec awesome
