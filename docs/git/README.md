# The note for git

## git config file

1. /etc/gitconfig：包含了适用于系统所有用户和所有项目的值。 git config --system
2. ~/.gitconfig：只适用于当前登录用户的配置。  git config --global
3. 位于git项目目录中的.git/config：适用于特定git项目的配置。
对于同一配置项，三个配置文件的优先级是1<2<3

```
    # autocrlf
    # Windows系统上，true，
    # git pull LF-->CRLF
    # git commit CRLF-->LF
    git config --global core.autocrlf true 
    
    # on git pull 不转换 
    # on git commit CRLF-->LF
    git config --global core.autocrlf input
    
    # git pull，git commit 都不进行转换，CRLF 提交到仓库中
    git config --global core.autocrlf false
    
    
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
    
    # 将本地dev分支推送远程master分支
    git push origin <本地分支名>:<远程分支名>
    git push origin dev:refs/for/master

    # 设置只推送当前分支
    git config --global push.default simple

    # 推送所有分支
    git config --global push.default matching

    # set http post buffer
    git config http.postBuffer 524288000 #524M

```

## About Proxy
### set
```
git config --global https.proxy http://127.0.0.1:1080
git config --global https.proxy https://127.0.0.1:1080

git config --global http.proxy 'socks5://127.0.0.1:1080' 
git config --global https.proxy 'socks5://127.0.0.1:1080'
```

### unset
```
git config --global --unset http.proxy
git config --global --unset https.proxy
```
