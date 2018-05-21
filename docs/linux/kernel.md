# kernel

### 列出所有kernel加载的模块
```
   lsmod
```

### 每个模块的详情
```
   modinfo 模块名
```

### 列出模块依赖性,并重新生成 /lib/modules/$(uname -r)/kernel/modules.dep文件
```
   depmod
   -n 在屏幕输出
```
### 手动加入模块
```
   modprobe
```
> modprobe会主动的去搜寻modules.dep的内容,先克服了模块的相依性后,才决定需要载入的模块有哪些

```
   insmod /lib/modules/$(uname -r)/kernel/fs/fat/fat.ko
```
> insmod则完全由使用者自行载入一个完整文件名的模块,并不会主动的分析模块相依性,**后面跟全路径**

### 删除模块
```
    rmmod -f 强制删除  同inmod，不会解析依赖关系
    modprobe -r 模块名  #删除模块
```
