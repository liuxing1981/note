# note for glance

### list all images
```
    glance image-list
```

### create a image
```
    glance image-create --name cirros \
    --file /tmp/cirros-0.3.4-x86_64-disk.img \
    --disk-format qcow2 \
    --container-format bare \
    --progress    
```

### delete
```
    glance image-list
    glance image-delete INAGE_ID
```