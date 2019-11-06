## 键位 backspace

### 按backspace 出现^H问题
```
showkey -a
按下backspace 对应的是^H,所以需要把^H映射为earse

在.bashrc
stty erase ^H

stty -a
查看earse对应的键是否为^H
```

### 按backspace 出现^?问题
```
stty earse ^?
```
