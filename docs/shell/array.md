# Array and Map

### 声明
```
#声明map
declare -A map

#声明数组
arr_number=(1 2 3 4 5)
arr_string=("abc" "edf" "sss")
arr_string=('abc' 'edf' 'sss')
```

### 数组长度
```
${#arr_number[@]}
```

### 赋值
```
arr_index0=${arr_number[0]}    ${arr_number[0]}="a"
arr_index1=${arr_number[1]}    ${arr_number[1]}="b"
arr_index2=${arr_number[2]}    ${arr_number[0]}="c"
```

### 删除
```
unset arr_number[1]　　　#清除一个元素
unset arr_number        #清除数组
```

### 遍历
```
#数组
for v in ${arr_number[@]}; do
　　echo $v;
done

#map
for key in ${!map[@]}; do
    echo $key
    echo ${map[$key]}    #value
done
```

### 切片
```
arr_number=(a b c d e a)
${arr_number[@]:1:4}，这里分片访问从下标为1开始，元素个数为4
#输出结果: b c d e
```

### 元素替换
```
arr_number=(a b c d e a)
echo ${arr_number[@]/a/z}   #输出结果: z b c d e z
```