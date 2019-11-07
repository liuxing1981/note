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
## vim script
### 映射--map
* map
* nmap normal
* vmap visual
* imap insert 输入模式下比较特殊

```
" 按ctrl+d 删除一行
:imap <c-d> <esc>ddi
```
### 精准映射-- noremap
防止递归map映射导致的问题，一般情况下都用noremap
* noremap
* nnoremap
* vnoremap
* inoremap

### Leader 前缀键
```
:let mapleader=","
:nnoremap <leader>d dd
```
