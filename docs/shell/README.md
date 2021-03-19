# The note for shell

## 获取当前运行脚本的目录
```
scripts_dir="$( cd "$( dirname "$0"  )" && pwd  )"
```

创建密码
```
openssl rand -hex 10
```

重定向
```
ls >/dev/null 2>&1
```
返回值
```
#返回<255的整数
function test()  
{  
    echo "arg1 = $1"  
    if [ $1 = "1" ] ;then  
        return 1  
    else  
        return 0  
    fi  
}  
  
echo   
echo "test 1"  
test 1  
echo $?     

#返回字符串,通过echo
function test()  
{  
    echo "arg1 = $1"  
    if [ $1 = "1" ] ;then  
        echo "19010"  
    else  
        echo "0"  
    fi  
}
echo "test 1"  
result=$(test 1)
```
