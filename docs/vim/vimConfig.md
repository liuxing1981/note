## 键位 backspace

### 按backspace 出现^H问题
```
showkey -a
按下backspace 对应的是^H,所以需要把^H映射为earse

在.bashrc
stty erase ^H

stty -a
查看erase对应的键是否为^H
```

### 按backspace 出现^?问题
```
stty erase ^?
```
## buffer
vim把文件load到内存中，一个内存中的文件对应一个buffer

## window
Window 只负责展示 Buffer 的数据且不会影响 Buffer
一个 Window 在同一时间内只能展示一个 Buffer，一个 Buffer 可以同时被多个 Window 展示，使用上一节中的命令可以切换 Window 中展示的 Buffer

## tab
Tab 是一系列 Window 的集合，是一种 “布局”。一个 Tab 上可以有多个 Window，不同 Tab 之间的 Window 互不影响。
## vim 设置
```
set value
set value!  取反，相当于no
set value?  get当前value的值
```
### 属性设置
```
set nu
set list
set ic ignorecase 查找忽略大小写
set sw=4 shiftwidth 缩进
set ts=4 tabstop tab为空4格
set et expandtab 用空格代替tab
set cul cursorline 一条行线
set paste
set hls hlsearch 
set sm showmatch 显示匹配的括号
set ff=unix 文件编码
set bg=dark
