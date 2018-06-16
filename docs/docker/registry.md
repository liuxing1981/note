##
```
docker run -d --restart=always -p 5000:5000  -e REGISTRY_STORAGE_DELETE_ENABLED=true  -v /opt/docker_volumes:/var/lib/registry registry:2
```