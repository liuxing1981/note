## git lfs 二进制大文件存储
### 大文件单独存储在别的地方，不占用git repo的资源
```bash
git lfs install #任意位置
git lfs track # 当前repo下，列出哪些二进制文件被lfs追踪
git lfs track "*.png" # 将某些文件加入到lfs过滤器中
git lfs untrack "*.psd"
git lfs status
git lfs ls-files  # 列出所有的lfs文件
git lfs pull # 手动拉取大文件
```


执行完 git lfs tarck "*.zip"等命令后，会自动生成一个  .gitattributes文件，里面记录了刚才添加的过滤文件

需要把这个文件提交上去

```
git add .gitattributes
git commit 
git push origin master
```



## 安装

```bash
# for centos 
yum install git-lfs

# for ubuntu
apt-get install git-lfs

# other
wget https://github.com/git-lfs/git-lfs/releases/download/v2.12.0/git-lfs-linux-amd64-v2.12.0.tar.gz
tar -zxvf git-lfs-linux-amd64-v2.12.0.tar.gz
cd git-lfs-linux-amd64-v2.12.0.tar.gz
sudo ./install.sh
```

