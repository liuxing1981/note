# shell　变量操作

### 赋值替换

> ${parameter:-word}
> 变量为空，表达式值=word
```
parameter=
echo ${parameter:-word}   #输出结果:word
echo $parameter           #输出结果: 空
```


> ${parameter:=word}
> 变量为空，表达式值=word,并且变量值=word
```
parameter=
echo ${parameter:-word}   #输出结果:word
echo $parameter           #输出结果:word
```

> ${parameter:?word}
> 变量为空，word为错误输出
```
parameter=
echo ${parameter:?word}  #输出结果:  bash: parameter: word
echo ${parameter}        #输出结果:  空
```
> ${parameter:+word}
>变量不为空，变量=word

```
parameter=a
echo ${parameter:+word}  #输出结果: word
echo ${parameter}        #输出结果: a
```

### 长度
```
 ${#parameter}
```

### 截取
```
file=/dir1/dir2/dir3/my.file.txt

${file#*/}   dir1/dir2/dir3/my.file.txt
${file##*/}  my.file.txt
${file#*.}   file.txt
${file##*.}  txt
${file%/*}   /dir1/dir2/dir3
${file%%/*} 拿掉第一条 / 及其右边的字符串：(空值)
${file%.*}   /dir1/dir2/dir3/my.file
${file%%.*}  /dir1/dir2/dir3/my

echo ${string: -4}    //2341  ：右边有格   截取后4位
```

```
${parameter:offset}从offset到结束
${parameter:offset:length}从offset开始截取n个
```

### 替换
```
${parameter/pattern/string}  /表示只替换一次
${parameter//pattern/string} //表示全部替换，用\表示转义
```