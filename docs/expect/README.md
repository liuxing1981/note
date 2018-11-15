# The note for expect

## use su - send a command and exit
```
#!/usr/bin/expect     
set timeout 30
set password root
set command "systemctl  status sshd"
spawn su -
expect "Password:"
send "$password\r"
expect "root"
send "$command\r"
expect "root"
send "exit\r"
#interact  
expect eof
```


## use ssh to login
```
    #!/usr/bin/expect -f  
    set ip [lindex $argv 0 ] 
    set password [lindex $argv 1 ]  
    set timeout 10  
    spawn ssh root@$ip
    expect {
    "*yes/no" { send "yes\r"; exp_continue}  //第一次ssh连接会提示yes/no,继续  
    "*password:" { send "$password\r" }      //出现密码提示,发送密码  
    }  
    interact
```

```
-c 可执行命令的前置符，其后的命令应该被引起来，该选项可以使用多次，每个-c可以跟多个以分号分隔的命令。命令按照出现的顺序执行,例如：
expect -c "puts first\n; puts second" -c "puts three"

-d 输出一些诊断信息，命令执行时的内部动作。当你写的脚本和预期不符时，可用此项来调试脚本

-D 交互式的调试器，类似gdb。适合专业人士使用

-f 指定Expect读取的文件，如果文件是-，则表示是从标准输入读取。该选项会将文件一次性全部读入内存，该选项是可选的

-b 类似-f选项，只是每次只读取一行

-i 以交互的方式运行expect，等效直接敲expect

-- 可以用来界定选项的结束，此项可以用在当你想传递一个类似选项的参数时，防止Expect误认为是选项

-N/-n 如果$exp_library/expect.rc和~/.expect.rc存在，Expect会分别自动读取，若要阻止此过程则需要分别指定-N和-n。此项一般用不上。

-v 输出版本号并退出
```