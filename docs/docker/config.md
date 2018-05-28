# registry-mirror
```
    vim /etc/docker/daemon.json
    {
    "registry-mirrors": ["http://ef017c13.m.daocloud.io"],
    "live-restore": true
    }
    systemctl daemon-load
    systemctl restart docker
```

# 时速云
```
    https://hub.tenxcloud.com/
```