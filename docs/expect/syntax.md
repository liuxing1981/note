# expect syntax

### 转义字符
```
\n 换行
\r 回车
```

### $argc 参数个数
```
if {$argc != 1} {
    send "usage ./account.sh \$newaccount\n"
    exit
}
```

### set 赋值语句
```
set prompt [lindex $argv 0]  
set def [lindex $argv 1]   
set response $def  
set tout [lindex $argv 2]  set user [lindex $argv 0]
set pass "root"

# 数组 在Tcl中数组是无序的数据结构(以哈希表的方式存储),而列表才是有序的排列
array set week {
    Mon 1
    Tue 2
    Wed 3
}
puts $week(Mon)
```
### set timeout 默认为10s,-1为无限
set timeout命令设置后面所有的expect命令的等待响应的超时时间为$tout(-l参数用来关闭任何超时设置)

### spawn 运行命令语句
* -noecho 默认情况下，spawn会回显命令名和参数。此选项可以取消回显。
* -ignore 指定在spawned process种要忽略的信号。
```
spawn chsh $user
spawn ssh -l username 192.168.1.1
```

### expect 需要等待出现的字符
* -gl 保护以"-"开始的模式不被认为是选项
* -re 正则表达式，在单项前面指定
* -ex 匹配确切的字串，不对*、^和$等特殊字符进行翻译
* -nocase 不区分大小写
* -timeout 设置当前expect的超时时间，而不是使用变量timeout的时间

```
expect -re "\[(.*)]:"    # -re正则，()用于捕获
if {$expect_out(1,string)!="/bin/tcsh"} {  
    send "/bin/tcsh" 
}
expect_out 抓取括号捕获，0表示整个字符，1表示第一个括号

expect "password:"
```

### expect_user 从标准输入读入，以'\r'结尾

### send 发送命令到当前进程
send会将expect脚本中需要的信息发送给spawn启动的那个进程
```
send "yes\r"  #\r表示回车
```
### send_user 发送到标准输出
send_user命令用来发送到父进程(一般为用户的shell)的标准输出。   

### puts 打印到标准输出，tcl语法
```
puts –nonewline  "hello hello"  #不打印换行
```

### send_error 发送到标准错误

### send_log [--] string 发送给指定文件

### send_tty 发送到/dev/tty


### 并行执行
```
expect {
        "assword" {
            send_user "sudo now\n"
            send "$passwd\n"
            exp_continue
        }
        eof
        {
            send_user "eof\n"
        }
```

# TCL

### append命令
该命令用于在字符串的末尾添加一个字符，特点:因这是Tcl的内部表达式，处理起来速度快！
```
set a "hello"
append a " world"
pust $a
```

### [] 命令执行替换
```
set b [set a   5] #set a 5 命令输出的结果赋给 b 
set c [expr 5 * 10]
```

### {} 不替换

```
puts "$a"  #会替换
=>123
puts {$a}  #不替换
=>$a
```

### 内置变量
* env  $env(HOME)   $env(PATH)
* argc 参数个数
* argv 参数列表  [lindex $argv 0]
* argv0 文件名