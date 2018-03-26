xset s off         # Don't activate screensaver.
xset -dpms         # Disable Energy Star features.
xset s noexpose    # Disallow window exposure.
xset s noblank     # Don't blank the video device.
xset r rate 170 70 # Fast keyboard repeat.

pkill xbindkeys; xbindkeys &
pkill nm-applet; nm-applet &
pkill pasystray; pasystray &
pkill xscreensaver; xscreensaver -nosplash &

exec awesome
