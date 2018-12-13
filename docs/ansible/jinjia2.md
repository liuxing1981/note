# jinjia2

## 字符串截取
```
name=abcdef
{{ name[start:end] }}
{{ name[:-2] }} //abcd
{{ name[:2] }} //ab
{{ name[2:3] }} //c
```

## Syntax

{\% ... \%} //语句
{\{ ... }\} //变量输出
{# ... #} //语句注解
\#  ... \#\# //可以代替{\%}执行语句，其中\#\#为注解部分 (ansible不好用)

# for user in users:
{{user.name}} \#\# This is a comment
# endfor
* \+
* \-
* \*
* /
* // 相除取整数部分 {{ 20 // 7 }} is 2.
* % 余
* ** 乘方 2**4 16
* in
* is 是Tests，用于判断
* | Filters，过滤器
* ~ 用于连接变量 {{ "Hello " ~ name ~ "!" }} Hello world!
  
### if
```
{\% extends layout_template if layout_template is defined else 'master.html' \%}
{\% if var is undined \%}
ok
{\% endif \%}
```

### for
* loop.index 	The current iteration of the loop. (1 indexed)
* loop.index0 	The current iteration of the loop. (0 indexed)
* loop.revindex 	The number of iterations from the end of the loop (1 indexed)
* loop.revindex0 	The number of iterations from the end of the loop (0 indexed)
* loop.first 	True if first iteration.
* loop.last 	True if last iteration.
* loop.length 	The number of items in the sequence.
* loop.cycle 	A helper function to cycle between a list of sequences. See the explanation below.
* loop.depth 	Indicates how deep in a recursive loop the rendering currently is. Starts at level 1
* loop.depth0 	Indicates how deep in a recursive loop the rendering currently is. Starts at level 0
* loop.previtem 	The item from the previous iteration of the loop. Undefined during the first iteration.
* loop.nextitem 	The item from the following iteration of the loop. Undefined during the last iteration.
* loop.changed(*val) 	True if previously called with a different value (or not called at all).
```
{\% for user in users \%}
{{user.name}}
{\% endfor \%}
```
### with (new version 2.3)
代码块，里面的变量为局部变量，离开with块就失效。

```
{\% with \%}
    {\% set foo = 42 \%}
    {{ foo }}   foo is 42 here
{\% endwith \%}
foo is not visible here any longer
```

## Tests
> Tests就是包含is的语句
```
{\% if loop.index is divisibleby 3 \%}
{\% if loop.index is divisibleby(3) \%}
```
* defined
* eq
* escaped
* even 是否为偶数
* ge >=
* gt > {\% if var is gt 3 \%}  {\% if var > 3 \%}
* lower 是否为小写
* mapping 是否为字典
* le
* lt
* iterable 是否可以遍历
* ne
* none
* number
* odd
* string
* undefined 
* upper