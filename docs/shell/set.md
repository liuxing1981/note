# set

## 定义
set 用于显示所有的shell变量
env 用于显示所有用户变量
```
#设置的是set变量，用set命令可以查看
a=b

#设置的是env变量，用env命令可以查看
export a=b 
```

## 参数
### set -u 
严格检查变量定义模式，如果有变量没有定义，则报错，程序退出执行


### set -x 
debug模式


### set -v 
debug详情模式，与-x连用
```
set -vx
```

### set -e 
只要有一个命令执行失败，程序就退出


### set -o pipefail  
管道的时候，只要最后一个命令成功，就认为命令执行成功了。这个参数可以防止这种情况。管道只要一个命令失败，程序就退出。


### bash调试连用
```bash
set -euxvo pipefail
```

### set -o vi
默认命令行为emacs。设置为vi模式