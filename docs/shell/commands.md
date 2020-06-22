## grep
* -l 只显示文件名
* -q 静默输出结果
* -r --include=\*.sh 只搜索指定的文件
* -r --include=\*.{sh,md} 只搜索指定的多种文件
* -r --exclude=a.md --exclude=b.md 排除指定的文件
* -r --exclude-dir=.git 排除文件夹
* -c 查到匹配的行数
* -b -o 打印偏移量
* -o 截取匹配字符
* -Z 返回结果以\0为终止符，与后面xargs -0 连用
* -A 匹配行后几行
* -B 匹配行前几行
* -C 匹配行前后几行
* --color=auto 颜色标注

## find
* ! 表示否定
```
find . ! -name "*.sh"
```
* -name 匹配文件
* -iname
* -path 匹配路径或文件
* -regex 正则全匹配 
```
find . -regex ".*\(\.md\|\.sh\)$"
```
* -iregex 
* -size +大于，-小于; b 块;c 字节;w 字;k M G 
```
find . -size +100k
```
* -type d 目录;f 文件;l 链接;s 嵌套字;c 字符设备;b 块设备;p Fifo
* -atime/mtime/ctime 单位为天  +7 大于7天  -7 七天之内
* -amin/mmin/cmin 单位为分钟
* -newer 比指定文件更新的文件
* -perm
* -o 
```
find . -name "*.sh" -o -name "*.md"
find . \( -name "*.sh" -o -name "*.md" \) -print
```
* -print 打印结果，以\n作为分割符
* -print0 打印结果，以\0作为分割符,配合xargs -0
* -maxdepth 遍历最大深度，遍历几级目录
* -mindepth 返回距离起始路径超过一定深度的文件，打印深度距离当前目录是2个子目录
```
# 只在深度为2级的目录下查找
find . -mindepth 2 -type f -print
```
* -user 找指定用户的文件
> find命令的输出是一个单数据流
```
# 把所有c语言文件合并成一个
find . -type f -name "*.c" -exec cat {} \;>all_c_files.txt
```
* -prune 修剪--忽略某些目录
```
find . \( -name ".git" -prune \) -o \( -type f \)
```

# xargs
> 把标准输出的参数转成命令行参数
* 多行变单行，xargs可以把\n转换成空格
* -n 每行几个参数
* -d 指定定界符
* -I {} 指定后面要替换的占位符
* -0 以\0为定界符
```
# 统计c语言文件的行数
find . -type f -name "*.c" print0 | xargs -0 wc -l
```
### NOTE
```
cat files.txt | (while read arg; do cat $arg;done)
```

# tar
* -C 解压到指定路径
* -cvf 打包
* -xvf 解包
* -tvf 显示tar包内容
* -tvvf 显示详情
* -Af 和合并tar文件
```
# merge f2.tar to f1.tar
tar -Af f1.tar f2.tar
```
* -rf 向tar包添加文件
```
tar -rf f1.tar file1 file2
```
* -uvvf 根据访问时间进行添加
* --delete 删除tar包中的文件
```
tar -f a.tar --delete file1 file2
```
* -z gzip
* -j bzip2
* --lzma lzma
* --exclude "*.txt" 排除某个文件，用双引号
* -X 把要排除的文件放到文件中
```
tar -cf a.tar -X list
cat list
file1
file2
file3
```
* --exclude-vcs 除去版本控制的目录 .git/sbuversion等
* --totals 打包完成后，显示字节数
* -a 根据扩展名自动选取解压算法
```
tar -xavvf a.tar.gz -C dir1
```



