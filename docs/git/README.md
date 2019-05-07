# The note for git

```
    # alias
    alias push='push() { [ "$1" ] && git push origin HEAD:refs/for/$1 || echo "no branch name";git branch;};push'

    # 设置编辑器vim
    git config --global core.editor "vim"

    # 设置忽略file mode
    git config core.fileMode false

    # 将本地的master分支推送到origin主机，同时指定origin为默认主机，后面就可以不加任何参数使用git push 
    git push -u origin master
 
    # 将当前分支推送到远程的同名分支
    git push origin HEAD

    # 设置只推送当前分支
    git config --global push.default simple

    # 推送所有分支
    git config --global push.default matching

    
```
