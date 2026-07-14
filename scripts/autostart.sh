#!/bin/bash
# AcreetionOS Awesome WM autostart

# Compositor
pkill picom
picom --config /etc/xdg/picom/picom.conf &

# Wallpaper
feh --bg-scale /usr/share/backgrounds/acreetionos-awesome-wallpaper.png &

# Network
nm-applet &

# Bluetooth
blueman-applet &

# Notifications
dunst &

# Policy kit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Cursor
xsetroot -cursor_name left_ptr &

# Keyboard repeat rate
xset r rate 250 40 &

# Numlock
numlockx on &

# Xresources
xrdb -merge ~/.Xresources 2>/dev/null || true

# Compositor
pkill picom
picom --config /etc/xdg/picom/picom.conf &
