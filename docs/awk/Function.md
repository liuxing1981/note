# awk build-in function

### srand/rand 随机数
* srand()  种子
* rand()   随机生成0~1之间的数

```
awk 'BEGIN{srand() print rand()}'
```

### int 取整数
### gsub/sub 替换函数
* gsub第三个参数默认为$0
* sub 只替换一个符合条件的

```
# 第一列中有l的，换成L
awk -F: '$1~/l/{ gsub("l","L",$1); print $1}' /etc/passwd

```

### length(str/array) 获取字符串长度
### index($1,"lee") 返回字符出现位置
### split(字符串,数组,分隔符)

```
awk 'BEGIN{ts="a,b,c,d,e,f,g";split(ts,arr_ts,",");for(i in arr_ts) print arr_ts[i]}'
```

### asort(arr) 根据value的值进行排序，但是会把文本下标变成数字。返回值为数组长度

```
# 保持旧数组不变，生成新数组,新数组也是数字下标
asort(old_arr,new_arr)
```    

### asorti 按照下标进行排序

### 三目运算符 result=条件?a:b 满足条件a，否则b
```
awk -F: '{user=$3>500?"user:":"system:";print user,$1}' /etc/passwd
```
