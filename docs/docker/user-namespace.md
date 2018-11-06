# user-namespace

## 说明
#### 默认容器里是root用户，如果不做用户隔离，那么容器里的root用户就等同于宿主机的root用户，很危险．容器里建立的文件所有者都是root的，如果映射到主机volume,如果主机的用户不是root,则无法访问这些volume
例如：
```
figo@localhost:~docker run -it -v /home/figo:/root ubuntu bash
```
以figo用户启动一个容器，并且把自己home目录挂载进去，这时如果在**容器里**运行
```
    mkdir -p /root/test
```
会在/home/figo的目录下多出一个test目录，但是owner是root，作为用户figo是无法访问这个目录的


## 开启用户隔离
```
    cat /etc/docker/daemon.json

    {
        "userns-remap":"default"
    }
```
#### 这样启动docker的时候，会在系统里建立一个默认的账户dockremap和组
```
    cat /etc/passwd | grep dockremap
```


## 自定义用户
> 自定义一个用户，用于容器的root,这个用户在系统必须存在
```
    cat /etc/docker/daemon.json

    {
        "userns-remap":"figo:users"
    }
```

> 如果docker启动失败，可能是没有定义/etc/subuid,/etc/subgid这两个文件，在RHEL,CentOS 7.3,opensuse中，这两个文件不会被自动创建，所以要自己创建
```
    echo "figo:1000:65535" >/etc/subuid
    
    echo "users:100:65535" >/etc/subgid
```
 
* figo:1000:65535的意思是　用户名:uid:uid-range
也就是1000这个uid对应容器的0,也就是root,1001对应容器里的uid 1,最大范围是65535

* 可以在/etc/subuid里配置多个不重叠的用户，但是由于系统内核原因，最多只有5个会起作用，放到/proc/self/uid_map和/proc/self/gid_map


## NOTE
> Enabling userns-remap effectively **masks** existing image and container layers, as well as other Docker objects within /var/lib/docker/. This is because Docker needs to adjust the ownership of these resources and actually stores them in a subdirectory within /var/lib/docker/. **It is best to enable this feature on a new Docker installation rather than an existing one.**
Along the same lines, if you disable userns-remap you can’t access any of the resources created while it was enabled.

官方建议在一个新装的docker上配置userns-remap，因为只要启动了userns-remap，之前的镜像和容器都因为权限问题访问不到了


## 在容器中禁止userns-remap
```
    docker run --userns=host ubuntu bash
```

## 不兼容性

* sharing PID or NET namespaces with the host (--pid=host or --network=host).
* external (volume or storage) drivers which are unaware or incapable of using daemon user mappings.
* Using the --privileged mode flag on docker run without also specifying --userns=host.
