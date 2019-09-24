# Linux usb boot disk

## umount Usb

```bash
sudo fdisk -l
sudo umount /dev/sdb*
```



## format Usb

```bash
sudo mkfs.vfat /dev/sdb –I
```



## write iso to Usb

```bash
sudo dd if=/home/bibi/Ubuntu_15_10_64.iso of=/dev/sdb
```

