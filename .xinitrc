#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset -b #Disable the annoying beep!
syndaemon -t -d -i 0.2 &

/home/hersh/scripts/conky_start.sh &

# Set the keymap
xmodmap /home/hersh/.Xmodmap &

# Source .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Disable the middle-click (it pastes stuff, which is irritating while using two-finger scroll)
xinput set-button-map "15" 1 25 3

# Udiskie to automatically handle mounting of USB drives etc.
udiskie --tray &

# run systemd as a user instance (for mpd)
/usr/lib/systemd/systemd --user & 

# Start 'remind' as a daemon which displays reminders as notifications.
# remind -z -k'notify-send --expiry-time 10000 "Reminder" %s &' ~/.reminders &

# Dropbox Client
dropboxd &

exec awesome
