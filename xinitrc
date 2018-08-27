#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login
xset +dpms # enable auto-standby of the monitor [redundant as setting dpms values implicitly enables dpms]
xset dpms 1000 0 0 # standby, suspend off (0 to deactivate)
xset s 720 180 # Send notification after 12 min and lock 3 mins after notification (in total after 15 min)
msg_txt="Architect is going to lock in 3 mins due to inactivity"
xss-lock -n "notify-send -u critical -t 3000 -i notification-display-brightness Autolock '$msg_txt'" i3lock-fancy &
exec i3