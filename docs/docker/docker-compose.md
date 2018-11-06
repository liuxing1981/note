# docker-compose

## docker-compose up
> 默认情况，如果容器已经存在，则会删除原来的容器，重新建立

```
    #如果不希望重新建立使用
    docker-compose up --no-recreate
```

```
    #只启动重新单个服务,会删除旧服务，启动一个新的
    docker-compose up --no-deps <SERVICE_NAME> -d
```

## 命令说明
* build
* config
* down
* exec
* help
* images
* kill
* logs
* pause
* port
* ps
* pull
* push
* restart
* rm
* run
* 