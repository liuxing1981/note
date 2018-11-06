## ssh 设置
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

