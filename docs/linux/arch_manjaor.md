## network

arch用netctl管理网络

网卡的名字就是profile

```
ip link   # 查看网卡名字作为profile
```



在/etc/netctl/examples 里有很多模版文件

```bash
cd /etc/netctl/examples
cp xxx ../   # copy一个模版到/etc/netctl
修改文件
netctl reenable profile  # 用新的profile文件，清除缓存
netctl restart profile

ip a # 查看网络配置情况
```

## Pacman

### Install

```bash
pacman -Syu # 更新所有软件
pacman -Sy # 更新源后，安装
pacman -Ss # 搜索
```

## Query

```
pacman -Qs vim # 查找已经安装的软件，模糊查找
pacman -Qi vim # 显示安装软件包的详细信息
pacman -Ql vim # 查找vim安装过的文件
---------------------------------------------
vim /usr/share/man/fr/man1/rvim.1.gz
vim /usr/share/man/fr/man1/vim.1.gz
vim /usr/share/man/fr/man1/vimdiff.1.gz
vim /usr/share/man/fr/man1/vimtutor.1.gz
vim /usr/share/man/fr/man1/xxd.1.gz
vim /usr/share/man/it.ISO8859-1/
```

## Remove

```
pacman -Rs # 删除软件及不被其他软件使用的依赖
pacman -Rsn # 删除配置文件
```



## Downgrade

软件降级

```bash
downgrade package
```

