## vimCommand
#### echo
```
echo "hello world"
```
#### echom
通过:messages命令查看时，echom的信息保留
```
echom "hello world"
```

#### help
可以阅读各种命令,设置
```
:help numberwidth
```

#### map/nmap/imap/vmap 映射
#### noremap/nnoremap/noiremap/novremap 精准映射，防止映射的递归引用
#### nunmap 删除映射
#### abbrev 缩写替换
```
:iabbrev adn and
```
在insert模式下输入adn,会被替换成and，但是要set nopaste

