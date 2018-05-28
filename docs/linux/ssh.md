# socket 5
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

# 反向代理
> 把内网端口映射到外网端口，实现通过外网端口访问内网端口
```
    ssh -f -N -R 外网端口:内网地址:内网端口 root@外网地址
```

# 正向代理，端口转发
> 把本机的127.0.0.1上的端口，转发给自己的34560端口
```
    ssh -p 2222 -f -N -L *:34560:127.0.0.1:8080 root@127.0.0.1


    ssh -p 2222 -f -N -L *:34560:114.215.64.142:8080 root@114.215.64.142
``` 

