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

#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto

# exec compton -b &
# exec fcitx5 &
exec i3 -V >> ~/.config/i3/log/i3log-$(date +'%F-%k-%M-%S' 2>&1)
# exec sudo mount -t nfs 192.168.123.94:/export/share ~/NFS
[ -f "$HOME/.Xmodmap" ] && xmodmap "$HOME/.Xmodmap"
# exec xscreensaver -no-splash &
