# ssh 设置

## ssh-keygen

```bash
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
```



## ssh 远程登录问题
```
vi /etc/ssh/sshd_config
StrictModes no
PubkeyAuthentication yes
UsePAM no

Comment the line root@10.9.248.29
#AllowUsers oamsys cntdb provgw *sftp* #root@10.9.248.29
service sshd restart
chmod 600 ~provgw/.ssh/authorized_keys

```

```
    vi /etc/ssh/sshd_config

    #禁止密码登录
    PasswordAuthentication no
    
    #允许root登录
    PermitRootLogin yes

    #保持长连接
    ClientAliveInterval 3600
    ClientAliveCountMax 10 

```
## ssh config file
```
    Host lab
        HostName 192.168.0.1
        User root
        IdentityFile ~/.ssh/id_rsa
```

## ssh command
```
     ssh -o ConnectTimeout=3 -o ConnectionAttempts=5 -o PasswordAuthentication=no -o StrictHostKeyChecking=no root@$ip 
    #ConnectTimeout=3                   连接超时时间，3秒
    #ConnectionAttempts=5               连接失败后重试次数，5次
    #PasswordAuthentication=no          不使用密码认证,没有互信直接退出
    #StrictHostKeyChecking=no           自动信任主机并添加到known_hosts文件
```


## socket 5
* -f 输入密码后进入后台模式
* -N 不执行远程命令,用于端口转发
* -D socket5代理
* -L tcp转发
    (Specifies that the given port on the local (client) host is to be forwarded to the given host and port on the remote side.)
* -C 使用数据压缩,网速快时会影响速度
```
    # 把一台机器变为socket5 服务器,2个ip是一样的
    ssh -f -N -D ip:port root@ip
```

## 反向代理
> 把内网端口映射到外网端口，实现通过外网端口访问内网端口
```
    ssh -f -N -R 外网端口:内网地址:内网端口 root@外网地址
```

## 正向代理，端口转发
> 把本机的127.0.0.1上的端口，转发给自己的34560端口

```
    ssh -p 2222 -f -N -L *:34560:127.0.0.1:8080 root@127.0.0.1

    ssh -p 2222 -f -N -L *:34560:114.215.64.142:8080 root@114.215.64.142
```

## 堡垒机proxy

内网host_a,host_b,host_c三台机器，其中a机器是堡垒机，可以连接b,c和外网机器d

在host_d机器通过堡垒机host_a，直接ssh  到 host_b，host_c

设置如下：

#### In host_a(堡垒机):

1. 确保host_a可以无密码访问host_b,host_c

   ```
   # in host_a
   ssh-copy-id user@host_b
   ssh-copy-id user@host_c
   ```

2. 在host_a主机设置sshd_config,允许TCP转发

   ```
   vim /etc/ssh/sshd_config
   allowtcpforwarding yes
   
   systemctl restart sshd
   ```

#### In host_d--远程机:

1. 远程机host_d,可以无密码访问host_a

   ```
   ssh-copy-id user@host_a
   ```

2. scp 主机host_a的私钥到主机 host_d

   ```
   mkdir pri_key
   scp user@host_a:~/.ssh/id_rsa pri_key/host_a.rsa
   ```

3. 设置.ssh/config

   ```bash
   vi .ssh/config
   
   Host host_a
     Hostname 10.67.31.140
     User root
   
   Host host_b
     Hostname 10.67.31.149
     User root
     ProxyCommand ssh -q -F .ssh/config -W %h:%p host_a
     IdentityFile ~/pri_key/host_a.rsa
     
   Host slb02
     Hostname 10.67.31.150
     User root
     ProxyCommand ssh -q -F .ssh/config -W %h:%p host_a
     IdentityFile  ~/pri_key/host_a.rsa
   
   ```

4. 完成设置，测试

    ```
    ssh host_a
    ssh host_b
    ssh host_c
    ```