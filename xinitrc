#!/bin/sh

# load .Xdefaults for dzen
xrdb -merge ~/.Xdefaults

# enable restart X
setxkbmap -option terminate:ctrl_alt_bksp 

# disable CapsLock & map to Escape
setxkbmap -option caps:escape 

# call Xmodap if the above fails
xmodmap ~/.Xmodmap

# set wallpaper
nitrogen --restore &

# Numlock
numlockx &

# Keyboard Bindings
xbindkeys &

# Dropbox
dropboxd &

# hide cursor
unclutter -idle 2 &

# start terminal emulation daemon
/usr/bin/urxvtd -q -o -f &

# xautolock
xautolock -time 8 -locker slock -nowlocker slock -detectsleep &

# Scripts & WM
~/.scripts/dwm &
~/.scripts/conky &
exec dwm
