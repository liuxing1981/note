# vnc server on ubuntu18.04

# asign static ip
```
vi /etc/network/interfaces
auto ens32
iface ens32 inet static
address 10.67.27.139
netmask 255.255.255.128
gateway 10.67.27.254
dns-nameservers 135.252.34.156 135.252.128.166
```

# set proxy
```
vi /etc/bash.bashrc
export http_proxy=http://135.245.48.34:8000
export https_proxy=http://135.245.48.34:8000
```

```
sudo apt install tigervnc-standalone-server tigervnc-xorg-extension
# if error use
#The following packages have unmet dependencies:
# tigervnc-xorg-extension : Depends: xserver-xorg-core (>= 2:1.7.7)
#E: Unable to correct problems, you have held broken packages.
sudo aptitude install tigervnc-xorg-extension
```

```
sudo apt install ubuntu-gnome-desktop
sudo systemctl enable gdm
sudo systemctl start gdm
vncpasswd
vi ~/.vnc/xstartup

#!/bin/sh
# Start Gnome 3 Desktop 
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
vncconfig -iconic &
dbus-launch --exit-with-session gnome-session &

vi ~/vncStart.sh

#!/bin/bash
vncserver -kill :1
vncserver :1 -geometry 2560x1440 -depth 32 -localhost no

./vncStart.sh
```

