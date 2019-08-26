## is & is not 
* 内存地址相同

## in & not in

## 数学运算
* "/" 除号，精确到小数
* "//" 地板除,只保留整数
  
## 字符串
* r'aaa'  表示不进行转义
* str.encode('utf-8') 转成byte
* byte.decode('utf-8') 解析成字符串
  
## 定义只有1个元素的tuple时，需要写(1,)
> 定义的不是tuple，是1这个数！这是因为括号()既可以表示tuple，又可以表示数学公式中的小括号，这就产生了歧义，因此，Python规定，这种情况下，按小括号进行计算，计算结果自然是1。
所以，只有1个元素的tuple定义时必须加一个逗号,，来消除歧义

## range(100) 从0开始到99

## dict
* d.get('Thomas', -1) 这样取值key不存在可以返回默认值
* d.pop('Bob') 删除一个key，value
  
## set
* remove(key) 删除一个元素
* s1 & s2 交集
* s1 | s2 并集
* 只能放入不可变对象

## 函数
### 默认参数必须指向不变对象！
### 可变参数 *number
```
# *nums表示把nums这个tuple的所有元素作为可变参数传进去
numbers = (1,2,3,4,5)
def calc(*numbers):
    sum = 0
    for n in numbers:
        sum = sum + n * n
    return sum
calc(*numbers)
```

### 关键字参数 **kw
```
# kw获得的dict是extra的一份拷贝，对kw的改动不会影响到函数外的extra
def person(name, age, **kw):
    print('name:', name, 'age:', age, 'other:', kw)
extra = {'a':1,'b':2}
person('figo',25,**extra)
```

### 命名关键字
> 只可以用名称调用,* 后面的参数为命名关键字
> 如果没有可变参数，就必须加一个*作为特殊分隔符
```
def person(name, age, *, city, job):
    print(name, age, city, job)

def person(name, age, *args, city, job):
    print(name, age, args, city, job)
```

## 列表推导式 list comprehension
```
[ x.lower() for x in L if isinstance(x,str)]

# if .... else
[ x.lower() if isinstance(x,str) else x for x in L ]
```

## 生成器 generator
### 第一种方法很简单，只要把一个列表生成式的[]改成()，就创建了一个generator
```
>>> L = [x * x for x in range(10)]
>>> L
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
>>> g = (x * x for x in range(10))
>>> g
<generator object <genexpr> at 0x1022ef630>
```
### 如果一个函数定义中包含yield关键字，那么这个函数就不再是一个普通函数，而是一个generator
```
def odd():
    print('step 1')
    yield 1
    print('step 2')
    yield(3)
    print('step 3')
    yield(5)
```

### Class变为Iterable 实现 __iter__()方法

### yield from 的意义
如果yield返回值是一个可迭代的对象，如果继续想遍历这个对象，可以使用
```
for i in return_value:
    yield i
```
但是更好的方式是：
```
yield from return_value
```
这样的写法比较简洁
```
def flatten_list(lists):
    for item in lists:
        if isinstance(item,Iterable) and not isinstance(item, (str, bytes)):
            yield from flatten_list(item)
            # 等同于下列语句
            #for it in item:
            #    yield it
        else:
            yield item
```

### comment
* # 单行注解
* """ """ 多行注解
* ''' ''' 多行注解
* docstring 注解写在函数定义的第一条语句
```
def double(num):
    """Function to double the value"""
    return 2*num
print(double.__doc__
```

### 变量赋值
```
x = y = z = "same"
```

### 常量
Constants are put into Python modules and meant not be changed
```
vi constant.py
PI = 3.14
GRAVITY = 9.8

import constant
print(constant.PI)
print(constant.GRAVITY)
```

### 数字
* 整数不受长度限制，大小取决于内存
* 小数精度为15位
```
a = 0b1010 #Binary Literals
b = 100 #Decimal Literal 
c = 0o310 #Octal Literal
d = 0x12c #Hexadecimal Literal

#Float Literal
float_1 = 10.5 
float_2 = 1.5e2

#Complex Literal 
x = 3.14j
```

### 字符串
```
strings = "This is Python"
char = "C"
multiline_str = """This is a multiline string with more than one line code."""
unicode = u"\u00dcnic\u00f6de"
raw_str = r"raw \n string"

This is Python
C
This is a multiline string with more than one line code.
Ünicöde
raw \n string
```
