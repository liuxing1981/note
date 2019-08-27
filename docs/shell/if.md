# if 语句
## [] 是test命令，只能比较字符串，数字，文件
### 字符串 == !=
* -n 
* -z
* ==
* !=
* -a and
* -o or
* !  not
```
# ==,!=
a=1
b=1
c=1
[ "$a" == "$b" ] && echo equal
[ "$a" == "$b" -a "$a" == "$c" ] && echo and
```

### 数字
* -eq
* -gt
* -lt
* -ge
* -le
  
### 文件
* -e
* -f
* -d
* -L

## [[ ]] bash独有的，功能强大
* 运算符 >,<
* &&，||
* 正则

### 运算符
```
a=20
b=12
if [[ "$a" > "$b" ]];then echo man:x;fi
```

## &&,||
```
if [[ "$a" > "$b" && "$a">0 ]];then 
    echo max:a;
fi
```

### 正则表达式
```
URL="https://github.com"
if [[ "$URL" =~ ^https ]];then
    echo match
fi

URL="https://github.com"
patten="^https"
if [[ "$URL" =~ $patten ]];then
    echo match
fi
```
NOTE: 
* 用双[[ ]]
* 正则不需要引号

```
# 否定
URL="https://github.com"
if [[ ! "$URL" =~ ^git ]];then
    echo match
fi
```
