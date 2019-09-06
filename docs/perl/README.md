# The note for perl

## 命令行
*    -0<数字> (用8进制表示)指定记录分隔符($/变量)，默认为换行
*    -00 段落模式，即以连续换行为分隔符
*    -0777 禁用分隔符，即将整个文件作为一个记录
*    -a 自动分隔模式，用空格分隔$_并保存到@F中。相当于@F = split ”。分隔符可以使用-F参数指定
*    -F 指定-a的分隔符，可以使用正则表达式
*    -e 执行指定的脚本。
*    -i<扩展名> 原地替换文件，并将旧文件用指定的扩展名备份。不指定扩展名则不备份。
*    -l 对输入内容自动chomp，对输出内容自动添加换行
*    -n 自动循环，相当于 while(<>) { 脚本; }
*    -p 自动循环+自动输出，相当于 while(<>) { 脚本; print; }

> -n 不会打印，要显示调用print打印
> -p 会每行打印$_的值

## s///替换
```
    $b = $a =~ s/best/ggggggggggggg/r;
    #将$a的内容替换后赋值给$b,s///r
    # s/// 只返回$b
```

## 打印行号
```
   print "$. $_"
```

> 当调用system命令的时候，系统会将执行结果输出到屏幕，并且将执行结果返回值（0或者非0）传给$ret2 ；
然而反引号（``）将会把所有结果都保存到变量$ret1上，并且不会输出任何结
```
my ($cmd,$ret1,$ret2);
 
$cmd = "ls /tmp";
 
print "*************执行反引号结果*****************\n";
$ret1 = \`$cmd\`;
print "*************执行system结果*****************\n";
$ret2 = system($cmd);
print "*************反引号方式*****************\n";
print $ret1;
print "*************下面是system方式*****************\n";
print $ret2;
```

```
    my ($id,$name) = (split /\s+/)[2,4];
    my %hash = (split /\s+/)[2,4];
```

## 打印ps命令的内容 
```
open(PS, "/usr/bin/ps -aux | ");
#my @a=<PS>
while (<PS>) { print } # process the output of ps command one line at a time
close(PS);
# 或者
while(\`/usr/bin/ps -aux\`) {
    print;
}
# 或者
print for(\`ls -al\`);
```

## 输入
```
   chomp(my $input = <STDIN>);
```

## 读写文件
```
    open(IN,"<a") or die "The file is not found $!";
    print while(<IN>);

    open(OUT,">a") or die "The file is not found $!";
    print OUT $_ for(\`ls -al\`); #用while不可以
    close OUT;
```

## 执行shell命令
1. system  #返回执行结果 $?
2. \`command\`  #返回输出结果

## 非贪婪
* .+?
* .*? 
* {n,m}? 
* {m,}?

## 不捕获
* ?:
