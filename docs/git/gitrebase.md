## git rebase -i
### 合并多个commit为一个完整commit
```
  git rebase -i  [startpoint]  [endpoint]
  git rebase -i HEAD~3    # merge last 3 commit
```
* -i的意思是--interactive，即弹出交互式的界面让用户编辑完成合并操作，
* [startpoint]  [endpoint]则指定了一个编辑区间，如果不指定[endpoint]，则该区间的终点默认是当前分支HEAD所指向的commit(注：该区间指定的是一个前开后闭的区间)。
  
## merge option
* pick：保留该commit（缩写:p）
* reword：保留该commit，但我需要修改该commit的注释（缩写:r）
* edit：保留该commit, 但我要停下来修改该提交(不仅仅修改注释)（缩写:e）
* squash：将该commit和前一个commit合并（缩写:s）
* fixup：将该commit和前一个commit合并，但我不要保留该提交的注释信息（缩写:f）
* exec：执行shell命令（缩写:x）
* drop：我要丢弃该commit（缩写:d）

