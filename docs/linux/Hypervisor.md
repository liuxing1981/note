# Hypervisor 是一个虚拟硬件的中间层

## 直接建立在硬件之上
> 虚拟机直接运行在系统硬件上，创建硬件全仿真实例，被称为“裸机”型。
裸机型在虚拟化中Hypervisor直接管理调用硬件资源，不需要底层操作系统，也可以将Hypervisor看作一个很薄的操作系统。
这种方案的性能处于主机虚拟化与操作系统虚拟化之间。


## 建立在OS之上---VM
> 虚拟机运行在传统操作系统上，同样创建的是硬件全仿真实例，被称为“托管（宿主）”型。
托管型/主机型Hypervisor运行在基础操作系统上，构建出一整套虚拟硬件平台（CPU/Memory/Storage/Adapter），
使用者根据需要安装新的操作系统和应用软件，底层和上层的操作系统可以完全无关化，如Windows运行Linux操作系统。
主机虚拟化中VM的应用程序调用硬件资源时需要经过:VM内核->Hypervisor->主机内核，因此相对来说，性能是三种虚拟化技术中最差的

## KVM
> Kernel-Based Virtual Machine 基于内核的虚拟机，是Linux内核的一个可加载模块，
通过调用Linux本身内核功能，实现对CPU的底层虚拟化和内存的虚拟化，
使Linux内核成为虚拟化层，需要x86架构的，支持虚拟化功能的硬件支持（比如Intel-VT，AMD-V），是一种全虚拟化架构。
KVM在2007年2月被导入Linux 2.6.20内核中。从存在形式来看，它包括两个内核模块：kvm.ko 和 kvm_intel.ko（或kvm_amd.ko），
本质上，KVM是管理虚拟硬件设备的驱动，该驱动使用字符设备/dev/kvm（由KVM本身创建）作为管理接口，
主要负责vCPU的创建，虚拟内存的分配，vCPU寄存器的读写以及vCPU的运行。

#### KVM只虚拟CPU，内存
> KVM是linux内核的模块，它需要CPU的支持，采用硬件辅助虚拟化技术Intel-VT，AMD-V，
内存的相关如Intel的EPT和AMD的RVI技术，Guest OS的CPU指令不用再经过Qemu转译，直接运行，大大提高了速度，
KVM通过/dev/kvm暴露接口，用户态程序可以通过ioctl函数来访问这个接口

## QEMU---Quick Emulator
> QEMU：是一套由Fabrice Bellard编写的模拟处理器的自由软件，它是一个完整的可以单独运行的软件，可以独立模拟出整台计算机，包括CPU，内存，IO设备，
通过一个特殊的“重编译器”对特定的处理器的二进制代码进行翻译，从而具有了跨平台的通用性。
QEMU有两种工作模式：系统模式，可以模拟出整个电脑系统，
另一种是用户模式，可以运行不同与当前硬件平台的其他平台上的程序（比如在x86平台上运行跑在ARM平台上的程序
其代码地址 http://git.qemu.org/qemu.git ，有兴趣的同学可以自己去看看，目前最新的版本是2.7.0，在0.9.1及之前版本还可以使用kqemu加速器
（可以理解为QEMU的一个插件，用来提高QEMU的翻译性能，支持Windows平台），但1.0以后版本就只能使用qemu-kvm（只支持Linux）进行加速了，1.3版本后QEMU和QEMU-KVM合二为一了。

## QEMU-KVM
> QEMU-KVM：从前面对KVM内核模块的介绍知道，它只负责CPU和内存的虚拟化，加载了它以后，用户就可以进一步通过工具创建虚拟机（KVM提供接口），
但仅有KVM还是不够的，用户无法直接控制内核去做事情（KVM只提供接口，怎么创建虚拟机，分配vCPU等并不在它上面进行），
还必须有个运行在用户空间的工具才行，KVM的开发者选择了比较成熟的开源虚拟化软件QEMU来作为这个工具，并对其进行了修改，最后形成了QEMU-KVM。
在QEMU-KVM中，KVM运行在内核空间，QEMU运行在用户空间，实际模拟创建，管理各种虚拟硬件，QEMU将KVM整合了进来，
通过/ioctl 调用 /dev/kvm，从而将CPU指令的部分交给内核模块来做，KVM实现了CPU和内存的虚拟化，
但kvm不能虚拟其他硬件设备，因此qemu还有模拟IO设备（磁盘，网卡，显卡等）的作用，KVM加上QEMU后就是完整意义上的服务器虚拟化。
当然，由于qemu模拟io设备效率不高的原因，现在常常采用半虚拟化的virtio方式来虚拟IO设备
综上所述，QEMU-KVM具有两大作用：
1.提供对cpu，内存（KVM负责），IO设备（QEMU负责）的虚拟
2.对各种虚拟设备的创建，调用进行管理（QEMU负责）

## 安装KVM
#### 查看是否cpu是否支持KVM
```
egrep '(vmx|svm)' /proc/cpuinfo

modprobe kvm

##查看是intel还是AMD cpu
lsmod |grep kvm

# 安装
yum install -y qemu-kvm libvirt virt-manager
systemctl enable libvirtd
systemctl libvirtd start
ln -sv  /usr/libexec/qemu-kvm  /usr/bin/qemu-kvm
```
> 通过vnc进行连接



## QCOW2 and RAW
> qcow2 镜像格式是 QEMU 模拟器支持的一种**磁盘镜像**。它也是可以用一个文件的形式来表示一块固定大小的块设备磁盘
qemu-img是QEMU的磁盘管理工具，在qemu-kvm源码编译后就会默认编译好qemu-img这个二进制文件。qemu-img也是QEMU/KVM使用过程中一个比较重要的工具，可以用其创建两种格式（raw和qcow2）的虚拟机磁盘。

### 1、两种磁盘的区别

raw 启动的虚拟机会比 QCOW2 启动的虚拟机 I/O 效率更高一些(25%)
qcow2是一种当下比较主流的虚拟化磁盘格式，具有占用空间小，支持加密，支持压缩，支持快照的特点

* 更小的空间占用，即使文件系统不支持空洞(holes)；
* 支持写时拷贝（COW, copy-on-write），镜像文件只反映底层磁盘的变化；
* 支持快照（snapshot），镜像文件能够包含多个快照的历史；
* 可选择基于 zlib 的压缩方式
* 可以选择 AES 加密


### 2、qemu-img操作

创建虚拟机镜像
qemu-img create -f raw test.raw 8G

```
查看虚拟机镜像文件
qemu-img info test.raw
```

```
转化格式
qemu-img convert -c -O qcow2 test.raw test.qcow2
```

```
改变镜像文件大小（raw和qcow2都可以支持resize）
qemu-img resize test.raw +1GB
```

```
磁盘镜像快照（快照这个功能只支持qcow2格式，raw不支持）
qemu-img snapshot -a 1 test.qcow2
qemu-img snapshot -l test.qcow2
qemu-img snapshot -d 1 test.qcow2
qemu-img snapshot -l test.qcow2
```