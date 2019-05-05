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
```

```
vi ~/.vnc/xstartup
#!/bin/sh
# Start Gnome 3 Desktop 
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
vncconfig -iconic &
dbus-launch --exit-with-session gnome-session &
```

```
vi ~/vncStart.sh

#!/bin/bash
SESSION=$1
if [ ! $SESSION ];then
	SESSION=1
fi
vncserver -kill :$SESSION
vncserver :$SESSION +extension Composite
```

```
vi ~/.vnc/config
securitytypes=vncauth,tlsvnc
desktop=sandbox
geometry=2550x1440
dpi=96
alwaysshared
```


# Tigervnc
```
vi ~/.vnc/xstartup
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
#exec dbus-launch startxfce4
#deepin desktop
exec dbus-launch startdde
```

```
vi /etc/systemd/journald.conf
ForwardToWall=no

systemctl daemon-reload
systemctl restart systemd-journald
```