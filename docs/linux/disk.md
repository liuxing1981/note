# Disk

## 分区 partition
> 不能处理系统正在使用的分区，需要卸载umount
```
   fdisk  #MBR,磁盘容量<2T
   gdisk  #GPL,>2T
   cat /proc/partitions # 查看系统内核的分区表，创建新分区后要修改内核分区表
   partprobe -s  #更新内核分区表
```
> 分区决定把一个磁盘分成多少个分区，每个分区都是独立的块。这样方便管理，读取写入某个分区数据的时候，磁头只在这个分区移动。

## 格式化
> 将分区变为文件系统fs,文件系统有很多类型 xfs,ext4,ntfs等，指定了文件系统类型的类型后，才能与系统进行交互。
```
   #后面的参数不一样
   mkfs.xfs
   -f 强制格式化
   -d agcount=xxx 设置大小为cpu线程数，便于并行读写

   mkfs.ext4 #没有这些参数
```

```
    dumpe2fs -h /dev/sda1  #查看ext superblock信息
    xfs_info    #查看xfs superblock信息
```

## ext4
> 带有日志的ext2系统，有superblock,inode,data block,一个文件一个inode,若干个block
superblock 存放整个分区的块信息：有多少inode，使用了多少;有多少block,使用了多少
inode存放文件的所有者，权限，最后读取时间，block的位置等信息，一个inode
block 可以设置为1K,2K,4K，一般4K，
* 如果设置block较小，一个大文件会占用很多个block
* 如果设置block较大，一个小文件就会浪费4K的空间，造成资源浪费

## 修复,必须umount以后才能修复，但是/目录是无法被卸载的
```
    xfs_repair /dev/sda4
    fsck.ext4   
```