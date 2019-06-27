# awk Action
>{}以及里面的语句都是Action

例如: awk '{print $1;print $2}' 或者 awk '{print $1}{print $2}' 这两者是等效的

```
# 打印文件第一行
# Action中这么写
awk '{ if(NR==1) print $0}' /etc/passwd

# 关系模式中可以这么写
awk 'NR==1{print $0} /etc/passwd
```

### 找出uid大于500的用户
```
awk -F: '{if($3>500) {print "user:",$1} else {print "system:",$1}}' /etc/passwd | sort
```

### 循环
#### for  
``` 
awk 'BEGIN{
  for(i=0;i<10;i++){
      print i
  }
}'
```
#### while 和 do while
```
awk 'BEGIN{ do{print "test";i++}while(i<5) }'
```
#### continue,break
#### next
>结束处理当前行

```
# 跳过处理第二行
awk '{if(NR==2)next;print $0}' /etc/passwd
```

#### exit 
> 退出awk，但是END模式的语句会被执行

```
# start
# end
awk 'BEGIN{print "start";exit}{print $0}END{print "end"}' /etc/passwd
```

### Array
```
# 判断是否存在 6 in a
awk 'BEGIN{ a[0]='0'; a[1]='1'; a[2]='2'; a[3]='3'; if(6 in a ) print a[6]; else print "no such element!" }'

# 打印数组，for (key in array )
awk 'BEGIN{ a[0]='0'; a[1]='1'; a[2]='2'; a[3]='3'; for(i in a) {print i, a[i]}}'

# 统计单词出现的次数,统计一列
awk '{ count[$1]++ } END{for(i in a) print i,count[i]}' a

# 单词统计,统计每个单词
awk '{for(i=1;i<=NF;i++)count[$i]++} END{for(key in count)printf "%20s,%10s\n",key,count[key]}' README.md | sort -nr -k 2
``` 
