# awk
> 按行进行操作，找到一行，按照分隔符分割，然后处理下一行。

## 内置变量
* $0  整行
* $NF 最后一列
* FS  输入分隔符，默认为空格
* OFS 输出分隔符
* RS  输入换行符
* ORS 输出换行符
* NR  当前处理的行号
* NF  当前行字段个数
* FILENAME 文件名
* ARGC 参数个数
* ARGV 参数数组

```
#通过-v参数设置内置变量----分隔符
awk -v FS="#" '{print $1}'
awk -v OFS="++" '{print $1}'

#指定多个-v参数
awk -v FS="#" -v OFS="+++"

#不用任何OFS输出
awk '{print $1 $2}'

#awk变量定义
loc=qingdao
awk -v loc=$loc 'BEGIN{print loc}'
```

## 打印例子
```
#打印多行需要用","隔开
awk '{print $1,$2}'

#也可以自定义一列
awk '{print $1,$2,"hello world"}'
```

## 模式 Patten
>就是条件，满足某个条件才进行行处理

```
awk [option] 'Patten{Action} {Action}' file
```

### BEGIN模式
>用于最开头，即逐行处理文本之前

```
awk -F: 'BEGIN{print "helloworld"} {print $1,$2}' /etc/passwd
```

### END模式
>用于最后，即处理完所有文本之后

```
awk -F: '{print $1,$2} END{print "end"}'  /etc/passwd
```

### 关系运算模式
```
# 输出列数满足大于5的行
awk -F: 'NF>5{print $1,$2}' /etc/passwd
```
### 空模式
> 任何条件都没有，每行都进行处理

### 正则模式

```
#输出a-c开头的
awk '/^[a-c]/{print $0}' /etc/passwd
```

>NOTE: 默认使用的扩展正则，但是需要{3,4}的时候，需要加--posix参数

```
awk --posix '/b{1,2}/{print $0}' /etc/passwd
# 行范围
awk '/^b/,/^k/{print $0}' /etc/passwd
```

>NOTE:可以指定某列对正则的匹配

```
# 第三列是以1开头的，即打印uid是1开头的用户
awk -F: '$3~/^1/{print $0}' /etc/passwd
# $3!~// 正则取反
awk -F: '$3!~/^1/{print $0}' /etc/passwd
```

## printf
> 负责格式化数据

```
awk -F: '{printf "%s\n%s\n", $1,$2}' /etc/passwd

awk -F: '{printf "%25s\t%5s\n", $1,$3}' /etc/passwd
```
