# python note

## import re
### match
1.从开头判断是否匹配
```
if re.match(r'hello.*',a):
    print 'yes'
```
2.用m.groups()进行括号捕获,或者用m.group(1)抓取第一个括号匹配。
m.group(0) 代表所有匹配
如果正则里没有(),则m.groups()为空
note: match只匹配第一个匹配到的
```
a = 'hello-kitty hello-jack hello-world!!'
m = re.match(r'hello-([a-z]*)',str)
for g in m.groups():
    print g
#kitty
```

### search
1. 只要有匹配就算成功
``` 
a = 'a b c d hello ef g'
m1 = re.search(r'hello', a)
m2 = re.match(r'\w.*hello.*', a)
print(m1.group())
print(m2.group())a = 'a b c d hello ef g'
```

### findall
用来匹配所有的，match只匹配到第一个合适的就不再匹配了
```
a = 'hello-kitty hello-jack hello-world!!'
print(re.findall(r'hello-\w+',a))
#['hello-kitty', 'hello-jack', 'hello-world']
```
note:要注意findall正则里有()的部分。对于有括号捕获的部分，只捕获括号内的数据
```
a = 'hello-kitty hello-jack hello-world!!'
print(re.findall(r'hello-(\w+)',a))
#['kitty', 'jack', 'world']

print(re.findall(r'(hello)-(\w+)',a))
#['hello-kitty', 'hello-jack', 'hello-world']
```
不参与捕获的()用(?:
```
print(re.findall(r'(?:hello)-(\w+)',a))
#['kitty', 'jack', 'world']
```

### sub 
进行replace替换
```
print(re.sub(r'(\w+)-(\w+)',r'\2-\1',a))
#kitty-hello,world-hello,jack-hello

print(re.sub(r'(\w+)-(\w+)',r'\1-good',a))
hello-good,hello-good,hello-good

print(re.sub(r'(\w+)-(\w+)','good',a))
good,good,good
```

### split
```
print(re.split(r'\s+',a)) #按空格分割，返回一个list
```

