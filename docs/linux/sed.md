# sed

```
   #单引号替换成双引号
   sed "s/'/\"/g" test
```

## 行前添加i,行尾添加a
```
#5 i aaaaaaaa
sed "5 i aaaaaaa" file
sed "5 a aaaaaaa" file

# 第一行前面
sed "1 i aaaaaaa" file
# 最后一行后面追加
sed "$ a aaaaaaa" file
```

## 正则添加
```
sed "/hello/a bbbbbb" file
```

## c 替换匹配行
```
# 含有fish的行，都替换
sed "/fish/c This is my monkey, my monkey's name is wukong" my.txt
This is my cat, my cat's name is betty
This is my dog, my dog's name is frank
This is my monkey, my monkey's name is wukong
This is my goat, my goat's name is adam
```

## -n p 打印
> -n 用于屏蔽每次自动从模式空间里打印行的这种默认行为，p手动指定打印

## cmd打包
>cmd可以是多个，它们可以用分号分开，可以用大括号括起来作为嵌套命令
```
# 对3行到第6行，匹配/This/成功后，再匹配/fish/，成功后执行d命令
sed '3,6 {/This/{/fish/d}}' pets.txt
```

```
# 从第一行到最后一行，如果匹配到This，则删除之；如果前面有空格，则去除空格
sed '1,${/This/d;s/^ *//g}' pets.txt
```

## P,p
* p打印当前模式空间内容，追加到默认输出之后，即打印所有模式空间内容。
* P打印当前模式空间开端至\n的内容，并追加到默认输出之前。打印开头至\n之间的内容。
>sed并不对每行末尾\n进行处理，但是对N命令追加的行间\n进行处理，因为此时sed将两行看做一行。

## N,n
* n 读取下一行，覆盖模式空间的当前行，所以单独n代表： sed命令读取一行以后，存入模式空间，然后n读入下一行，覆盖当前的一行，当前模式空间只有第二行内容。sed再从第三行读起
* N 读取下一行，追加到模式空间

## D,d
* D命令是删除当前模式空间开端至\n的内容（不在传至标准输出），放弃之后的命令，但是对剩余模式空间重新执行sed。
* d命令是删除当前模式空间内容（不再传至标准输出），并放弃之后的命令，并对新读取的内容，重头执行sed。


## hold space
* g： 将hold space中的内容拷贝到pattern space中，原来pattern space里的内容清除
* G： 将hold space中的内容append到pattern space\n后
* h： 将pattern space中的内容拷贝到hold space中，原来的hold space里的内容被清除
* H： 将pattern space中的内容append到hold space\n后
* x： 交换pattern space和hold space的内容

## \[^,\]* 代替贪婪正则，取不包含，的  .*非贪婪写法 \[^,\]*

```
<b>This</b> is what <span style="text-decoration: underline;">I</span> meant. Understand?
sed 's/<.*>//g' html.txt   这种是贪婪匹配，会匹配到最后一个span
sed 's/<[^>]*>//g' html.txt  对应的非贪婪，贪婪的标记是>   [^>]*代替.*
```
