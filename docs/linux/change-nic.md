#修改网卡名称为eth0、eth1

### 修改网卡名称
```
cd /etc/sysconfig/network-scripts/
mv ifcfg-eno16777736 ifcfg-eth0
```

### 修改网卡配置文件
```
[root@bogon ~]# cat /etc/sysconfig/network-scripts/ifcfg-eth0
TYPE=Ethernet
BOOTPROTO=static
NETMASK=255.255.255.0
IPADDR=10.0.0.110
GATEWAY=10.0.0.2
DEFROUTE=yes
PEERDNS=yes
PEERROUTES=yes
IPV4_FAILURE_FATAL=no
NAME=eth0
UUID=582bec32-fa8b-415e-9cdc-873035dc336d
DEVICE=eth0
ONBOOT=yes
```

### 修改grub
> 增加net.ifnames=0 biosdevname=0到环境变量GRUB_CMDLINE_LINUX
> GRUB_CMDLINE_LINUX=net.ifnames=0 biosdevname=0
```
cat /etc/sysconfig/grub
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="rhgb net.ifnames=0 biosdevname=0 quiet"
GRUB_DISABLE_RECOVERY="true"
```

### 生成启动菜单
```grub2-mkconfig -o /boot/grub2/grub.cfg
```
### 重启系统
reboot
