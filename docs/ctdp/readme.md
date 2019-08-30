# 端口映射

### {% em type="green" %}k8s2-1 192.168.205.92{% endem %}
``` 
    #把本地的80映射到aliyun-minion1
    /usr/bin/ssh -f -N -v -R 80:127.0.0.1:80 root@114.215.64.143
```
> 把本地的80映射到aliyun-minion1，同时本地开启nginx做反向代理，例如zentao.eng.centling.com --> 192.168.206.93
> 实现通过外网域名，访问内网主机

### aliyun-master
``` 
    #把本地127.0.0.1监听的端口8080 转发到所有网卡的34560
    ssh -p 2222 -NL *:34560:127.0.0.1:8080 127.0.0.1
```
> 实现突破只有127.0.0.1监听的限制

### k8s2-10 192.168.205.31
```
    ssh -CfnNT -R 80:localhost:80 root@114.215.64.142 -p2222
```
> 把本地的80映射到阿里云master的80,同时外网把*.c1.centling.cn 映射到114.215.64.142,实现外网访问*.c1.centling.cn相当于访问内网的*.c1.centling.cn
