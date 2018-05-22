# kernel
```
    #kernel存放在
    /boot/vmlinuz-$(uname -r)
    #需要解压缩，然后载入内存
```

## 列出所有kernel加载的模块
```
   lsmod
```

## 每个模块的详情
```
   modinfo 模块名
```

## 列出模块依赖性,并重新生成 /lib/modules/$(uname -r)/kernel/modules.dep文件
```
   depmod
   -n 在屏幕输出
```
## 手动加入模块
```
   modprobe
```
> modprobe会主动的去搜寻modules.dep的内容,先克服了模块的相依性后,才决定需要载入的模块有哪些

```
   insmod /lib/modules/$(uname -r)/kernel/fs/fat/fat.ko
```
> insmod则完全由使用者自行载入一个完整文件名的模块,并不会主动的分析模块相依性,**后面跟全路径**


## 删除模块
```
    rmmod -f 强制删除  同inmod，不会解析依赖关系
    modprobe -r 模块名  #删除模块
```


## boot loader----grub2

* boot loader是一个程序，用于把操作系统的kernel从磁盘读入内存
* boot loader一般位于第一块磁盘的第一个sector(扇区)的一个block中，计算机启动之后，BIOS通过INT13中断能够读取到boot loader，还能读取到initramfs里面的文件，并把其挂载为虚拟的根目录。
* boot loader程序分为2部分，主程序存在boot sector中，配置文件存放在/boot/grub2/中，通过挂载虚拟根目录，读取配置文件的内容。并且通过loader把必要的磁盘驱动载入内存，然后卸载initramfs,挂载真实的根目录
* boot loader有很多种，每个操作系统都不一样，linux有lilo,grub等，但是centos7已经使用grub2了,windows有自己的boot loader

## boot loader的作用：
1. 提供一个开机菜单
2. 把内核载入内存
3. 把开机控制权转交给其他的boot loader
> 每次安装操作系统的时候，MBR里的boot loader程序都会被覆盖，但是windows的boot loader不具备第三个功能（控制权转换），不能由windows boot loader来启动其他的 如linux的boot loader，也就是说不能用windows启动linux，所有安装多系统的时候要先装wiwdows，然后装linux,这样linux的boot loader会覆盖之前windows的boot loader，最终是由linux boot loader启动，既可以直接启动linux，也可以把控制权转交给windows boot loader启动windows

## grub.cfg
### set default
### set timeout
### menuentry
* --class
* --unrestricted 
* --id
* set root='hd0,gpt2' #grub.cfg的位置，位于第一块磁盘的第二个分区，用gpt分区表
* linux16 /vmlinuz-3.10.0-693.21.1.el7.x86_64 #kernel文件的位置，如果没有有/boot分区，则为/boot/vmlinuz-3.10.0-693.21.1.el7.x86_64
* root=/dev/mapper/centos-root #root根目录的位置,kernel会主动挂载根目录，根目录的挂载可以是设备文件名、 UUID 与 LABEL
```
root=UUID=1111.2222.33...
```
* initrd16 /initramfs-3.10.0-693.21.1.el7.x86_64.img  #initramfs文件的位置，位于/boot下的initramfs-3.10.0-693.21.1.el7.x86_64.img文件

## grub2-mkconfig
系统不希望用户手动修改grub.cfg文件，所有提供一个模板文件，修改后用命令grub2-mkconfig自动生成grub.cfg文件
```
vi /etc/default/grub  #模板文件
grub2-mkconfig -o /boot/grub2/grub.cfg
```

### /etc/default/grub
```
GRUB_TIMEOUT=5 # 指定默认倒数读秒的秒数
GRUB_DEFAULT=saved # 指定默认由哪一个菜单来开机，默认开机菜单之意(menuentry)
GRUB_DISABLE_SUBMENU=true # 是否要隐藏次菜单，通常是藏起来的好！
GRUB_TERMINAL_OUTPUT="console" # 指定数据输出的终端机格式，默认是通过文字终端机
GRUB_CMDLINE_LINUX="rd.lvm.lv=centos/root rd.lvm.lv=centos/swap crashkernel=auto rhgb quiet"
# 就是在 menuentry 括号内的 linux16 项目后续的核心参数
GRUB_DISABLE_RECOVERY="true" # 取消救援菜单的制作
GRUB_TIMEOUT_STYLE #是否隐藏菜单项[menu | countdown | hidden]
```

## 菜单创建的脚本 /etc/grub.d/*
#### grub-mkconfig会按顺序执行/etc/grub.d/*里面的脚本来生成grub.cfg

* 00_header：设置参数，变量
> 主要在创建初始的显示项目，包括需要载入的模块分析、屏幕终端机的格
式、倒数秒数、菜单是否需要隐藏等等，大部分在 /etc/default/grub 里面所设置的变量，
大概都会在这个脚本当中被利用来重建 grub.cfg

* 10_linux：生成kernel对应的菜单
> 根据分析 /boot 下面的文件，尝试**找到正确的 linux 核心与读取这个核心需要
的文件系统模块与参数等**，都在这个脚本运行后找到并设置到 grub.cfg 当中。 因为这个
脚本会将所有在 /boot 下面的每一个核心文件都对应到一个菜单，因此核心文件数量越
多，你的开机菜单项目就越多了。 如果未来你不想要旧的核心出现在菜单上，那可以通
过移除旧核心来处理即可。

* 30_os-prober：其他分区的操作系统，生成菜单
> 这个脚本默认会到系统上找其他的 partition 里面可能含有的操作系统，
然后将该操作系统做成菜单来处理就是了。 如果你不想要让其他的操作系统被侦测到并
拿来开机，那可以在 /etc/default/grub 里面加上GRUB_DISABLE_OS_PROBER=true取消这个文件的运行。

* 40_custom：自定义菜单
> 如果你还有其他想要自己手动加上去的菜单项目，或者是其他的需求，那么
建议在这里补充即可！一般来说，我们会更动到的就是仅有 40_custom 这个文件即可

## 通过 chainloader 的方式移交 loader 控制权
```
vim 40_custom
menuentry "Windows" {
    insmod chain # 你得要先载入 chainloader 的模块对吧？
    insmod ntfs # 建议加入 windows 所在的文件系统模块较佳！
    set root=（hd0,1） # 是在哪一个分区～最重要的项目！
    chainloader +1 # 请去 boot sector 将 loader 软件读出来的意思！
}
```

## initramfs默认用gzip压缩
initramfs 可以将 /lib/modules/.... 内的开机过程当中一定需要的模块包成一个文件 （文件名
就是 initramfs）， 然后在开机时通过主机的 INT 13 硬件功能将该文件读出来解压缩，并且
initramfs 在内存内会仿真成为根目录， 由于此虚拟文件系统 （Initial RAM Disk） 主要包含磁
盘与文件系统的模块，因此我们的核心最后就能够认识实际的磁盘， 那就能够进行实际根目
录的挂载啦！initramfs 内所包含的模块大多是与开机过程有关，而主要以文件系统
及硬盘模块 （如 usb, SCSI 等） 为主！
```
    #查看文件内容
    lsinitrd initramfs-new.img
```

## 重新制作initramfs文件
```
#额外加入 e1000e 网卡驱动与 ext4/nfs 文件系统在新的 initramfs 内
[root@study ~]# dracut -v --add-drivers "e1000e" --filesystems "ext4 nfs" initramfs-new.img $（uname -r）
```

## 安装grub2
```
#安装到/dev/vda
grub2-install /dev/vda #如果后面跟上设备名，则写入MBR，否则只是复制文件到/boot/grub2
grub2-install --force --recheck --skip-fs-probe /dev/vda1  #在分区安装
```

```
mount -o remount,rw /sysroot
chroot /sysroot
```