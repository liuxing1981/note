## 键位 backspace

### 按backspace 出现^H问题
```
showkey -a
按下backspace 对应的是^H,所以需要把^H映射为earse

在.bashrc
stty erase ^H

stty -a
查看erase对应的键是否为^H
```

### 按backspace 出现^?问题
```
stty erase ^?
```
## vim script
### 映射--map
* map
* nmap normal
* vmap visual
* imap insert 输入模式下比较特殊

```
" 按ctrl+d 删除一行
:imap <c-d> <esc>ddi
```
### 精准映射-- noremap
防止递归map映射导致的问题，一般情况下都用noremap
* noremap
* nnoremap
* vnoremap
* inoremap

### Leader 前缀键
```
:let mapleader=","
:nnoremap <leader>d dd
```
### 命令隔离符 | 相当与shell的;
```
let a = "foo" | echom a
```

### 变量
```
let a = "foo"
echo a
```
#### 本地变量(只对当前的buffer有效) b:
```
let b:a = "foo"
```

### 选项--用&进行引用
```
set textwidth = 80
echo &textwidth
" boolean值显示0(false) 1(true)
set nu
echo &nu
```
### 寄存器--@
* 默认寄存器: "，所有的复制都放到默认寄存器"中
```
echo @"
```
* 搜索寄存器: /，保存刚才搜索过的单词
```
echo @/
```
* 普通寄存器
```
let @a = "hello world"
echo @a
```

### if语句,1=true
```
if 1
	echom "hello world"
elseif "something"
	echom "something"
else
	echom "finally"
endif
```
note: if "something" 返回false
* ==# 严格匹配
```
if "foo" ==# "foo"  true
```
* ==? 忽略大小写
```
if "foo" ==? "FOO"  true
```

```
use 'ignorecase'    match case     ignore case
equal                   ==              ==#             ==?
not equal               !=              !=#             !=?
greater than            >               >#              >?
greater than or equal   >=              >=#             >=?
smaller than            <               <#              <?
smaller than or equal   <=              <=#             <=?
regexp matches          =~              =~#             =~?
regexp doesn't match    !~              !~#             !~?
same instance           is              is#             is?
different instance      isnot           isnot#          isnot?
```

### 函数 function
NOTE: 没有作用域限制的Vimscript函数必须以一个大写字母开头！
调用: 
* call 调用没有返回值的函数
* 表达式里调用函数 echom Meow() 如果没有返回值，默认返回0
  这个表达式返回0
```
function Meow()
  echom "Meow!"
endfunction
call Meow()
```

### 函数的参数
NOTE: 在函数内使用参数，需要带上函数作用域a:
NOTE: 不能对函数参数重新赋值
NOTE: 多参数函数a:0 参数个数，a:1第一个参数，a:000 一个参数列表
```
function DisplayName(name)
	echom "Hello!  My name is:"
	echom a:name  " 这里用a:name
endfunction
```

### 字符串
用.进行连接
单引号，不进行转义
```
echo "hello"."world"
```
#### 字符串函数
* len 字符串长度
```
echom len("foo")
```
* split 分割字符串，默认分割符是空格,返回一个list
```
echo split("one two three")
echo split("one,two,three", ",")
```
* join
```
echo join(["foo", "bar"], "...")
```
* tolower/toupper 大小写转换

### Normal!

用于取消之前的映射，类似于noremap。

NOTE: 执行命令的时候一定要用 normal!

