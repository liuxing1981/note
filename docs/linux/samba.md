#samba

## opensuse
```
    systemctl start smb
    #默认是开启users的共享，即/home目录共享为users目录

    smbpasswd -a figo  
```
> 创建一个smb用户，这个用户必须是系统里的用户，创建之后，重启smb，会自动共享/home/figo这个目录

### 自定义一个共享目录
```
    sudo vim /etc/samba/smb.conf
#除了[global]，其他的都会被共享出来
[share]
        comment = Share Folder require password
        browseable = yes
        path = /home/figo
        create mask = 0777
        directory mask = 0777
        valid users = figo
        force user = nobody
        force group = nogroup
        public = yes
        writable = yes
        available = yes

    systemctl restart smb
```

### 测试
```
   #列出所有共享目录
   smbclient -L localhost -U figo%figo
```

```
    #进入smb客户端的console,类似ftp
    smbclient //localhost/figo -Ufigo%figo
```