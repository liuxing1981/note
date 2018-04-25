# live-restore

docker daemon重启，关闭的时候，保活正在运行的容器

## 配置方法
```
    cat /etc/docker/daemon.json
    {
         "live-restore": true
    }
```

## 总结
```
docker ps

CONTAINER ID        IMAGE                 COMMAND                 CREATED             STATUS                            PORTS                               NAMES
3c44382a2a82        liuxing1981/gitbook   "sh /root/startup.sh"   2 hours ago         Up 2 seconds (health: starting)   0.0.0.0:4000->4000/tcp, 35729/tcp   note

```

```
#先关掉docker,大约1分钟后，启动
systemctl stop docker
sleep 60s
systemctl start docker
```

```
docker ps
CONTAINER ID        IMAGE                 COMMAND                 CREATED             STATUS                                 PORTS                               NAMES
3c44382a2a82        liuxing1981/gitbook   "sh /root/startup.sh"   2 hours ago         Up About a minute (health: starting)   0.0.0.0:4000->4000/tcp, 35729/tcp   note

```

可以看到开始时up 2 seconds,在docker停止一分钟后重启，容器的启动时间是up About a minute.由此可见，配置了live-restore:true后，在docker服务停止以后，container是一直没有停止运行的，这样的好处是可以在docker启动后，容器直接就是好用的，省去了启动容器的时间。最大减少宕机的时间。
* 以前  宕机时间=docker daemon停止时间 + 容器启动的时间
* 现在  宕机时间=docker daemon停止时间

## Note
>  If any of these daemon-level configuration options have changed, the live restore may not work and you may need to manually stop the containers.

bridge IP addresses和graph driver这种docker的配置改变的话，live-restore不起作用

> 没有停止运行的容器还是会产生大量的log，如果log被填满，只能重启docker去flush log
```
   # 查看log buffer
   cat /proc/sys/fs/pipe-max-size
```