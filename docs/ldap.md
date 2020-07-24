# LDAP

* -c 遇到错误继续执行
* 

```
ldapadd -x -D "cn=root,dc=starxing,dc=com" -w secret -f /root/test.ldif
```
#### -D 表示cn=root的dn，-w输入的是这个人的密码，即用哪个用户(这里是root)登录进行操作

```
ldapdelete -x -D "cn=Manager,dc=test,dc=com" -w secret "uid=test1,ou=People,dc=test,dc=com" 
```

```
ldapmodify -x -D "cn=root,dc=it,dc=com" -w -f modify.ldif 
```

#### modify.ldif,增加一个字段，修改一个字段，删除一个字段
```bash
# cat modify_entry.ldif
dn: cn=Pete Minsky,ou=Marketing,dc=example,dc=com
changetype: modify
add: mail
mail: pminsky@example.com
-
replace: sn
sn: Minsky
-
delete: description
description: sx
```

#### 删除一个oc

```bash
dn: cn=Pete Minsky,ou=Marketing,dc=example,dc=com
changetype: delete
```

### ldapadd & ldapmodify

* ldapadd = ldapmodify -a

  ```
  dn: cn=Barbara Jensen,dc=example,dc=org
  objectClass: inetOrgPerson
  cn: Barbara Jensen
  cn: Babs Jensen
  sn: Jensen
  title: the world's most famous mythical manager
  mail: bjensen@example.com
  uid: bjensen
  ```

* ldapmodify + changetype: add

  ```
  dn: cn=Barbara Jensen,dc=example,dc=org
  changetype: add
  objectClass: inetOrgPerson
  cn: Barbara Jensen
  cn: Babs Jensen
  sn: Jensen
  title: the world's most famous mythical manager
  mail: bjensen@example.com
  uid: bjensen
  ```

> NOTE: ldapadd 等同于ldapmodify -a，他们用的ldif是一样的，但是可以用ldapmodify命令添加，需要把ldif文件加上changetype:add, 同理ldapdelete等同于ldapmodify changetype: delete

## ldapsearch -b 查询起始位置 查询条件 查询返回字段

##### -b 要查询的oc， 从哪一级开始查询

##### 查询条件 

* 模糊查询 ou=*

##### 查询返回字段： 不用加引号  sn cn title mail uid

```
ldapsearch -x -h 192.168.31.242 -p 389 -b "dc=example,dc=org" -D "cn=admin,dc=example,dc=org" -w admin "uid=*" sn cn title mail uid
```

> 查询dc=example, dc=org 下面所有的uid，返回 sn cn title mail uid 字段

### filter

* 等于(EQUAL TO)： =
* 大于等于(Greater than)：  >=
* 小于等于(Less than)：  <=
* 通配符(wildcard)： *
* 逻辑与(logical AND)： & 
* 逻辑或(logical OR)：  | 
* 逻辑非(logical NOT)：  !

以用户信息存储来举例，假设，用户目录树ou=user,dc=domain，结构如下：

```
 dc=domain
     |-ou=user
        |-cn=zhangsan
        |-cn=lisi
        |-cn=wangwu
        |-cn=zhaoliu  
```

用户信息属性如下：

```
  cn=zhangsan
  objectClass=top
  objectClass=person
  name=张三
  sex=男
  age=28
  pwd=123456
  email=zhangsan@163.com
  desc=描述
```

查询所有name为张三，sex为男的用户：
  `(&(name=张三)(sex=男))`

查询所有age不为28的用户：
  `(!(age=28))`

查询所有age为28，并且name不为张三的用户
  `(&(age=28)(!(name=张三)))`

查询所有age为28，或者name为张三的用户
  `(|(age=28)(name=张三))`

查询所有name的姓为张，或者desc包含描述的用户：
  `(|(name=张*)(desc=*描述*))`

查询所有有email为空的用户：
  `(email=)`

查询所有没有desc属性的用户：
  `(!(desc=*))`

查询所有有desc属性的用户：
  `(desc=*)`




## LDAP ERROR CODE

```
LDAP_SUCCESS = 0 //成功

LDAP_OPERATIONS_ERROR = 1 //操作错误

LDAP_PROTOCOL_ERROR = 2 //协议错误

LDAP_TIME_LIMIT_EXCEEDED = 3 //超过最大时间限制

LDAP_SIZE_LIMIT_EXCEEDED = 4 //超过最大返回条目数

LDAP_COMPARE_FALSE = 5 //比较不匹配

LDAP_COMPARE_TRUE = 6 //比较匹配

LDAP_AUTH_METHOD_NOT_SUPPORTED = 7 //认证方法未被支持

LDAP_STRONG_AUTH_REQUIRED = 8 //需要强认证

LDAP_PARTIAL_RESULTS = 9 //null

LDAP_REFERRAL = 10 //Referral

LDAP_ADMIN_LIMIT_EXCEEDED = 11 //超出管理员权限

LDAP_UNAVAILABLE_CRITICAL_EXTENSION = 12 //Critical扩展无效

LDAP_CONFIDENTIALITY_REQUIRED = 13 //需要Confidentiality

LDAP_SASL_BIND_IN_PROGRESS = 14 //需要SASL绑定

LDAP_NO_SUCH_ATTRIBUTE = 16 //未找到该属性

LDAP_UNDEFINED_ATTRIBUTE_TYPE = 17 //未定义的属性类型

LDAP_INAPPROPRIATE_MATCHING = 18 //不适当的匹配

LDAP_CONSTRAINT_VIOLATION = 19 //约束冲突

LDAP_ATTRIBUTE_OR_value_EXISTS = 20 //属性或值已存在

LDAP_INVALID_ATTRIBUTE_SYNTAX = 21 //无效的属性语法

LDAP_NO_SUCH_OBJECT = 32 //未找到该对象

LDAP_ALIAS_PROBLEM = 33 //别名有问题

LDAP_INVALID_DN_SYNTAX = 34 //无效的DN语法

LDAP_IS_LEAF = 35 //null

LDAP_ALIAS_DEREFERENCING_PROBLEM = 36 //Dereference别名有问题

LDAP_INAPPROPRIATE_AUTHENTICATION = 48 //不适当的认证

LDAP_INVALID_CREDENTIALS = 49 //无效的Credential

LDAP_INSUFFICIENT_ACCESS_RIGHTS = 50 //访问权限不够

LDAP_BUSY = 51 //遇忙

LDAP_UNAVAILABLE = 52 //无效

LDAP_UNWILLING_TO_PERform = 53 //意外问题

LDAP_LOOP_DETECT = 54 //发现死循环

LDAP_NAMING_VIOLATION = 64 //命名冲突

LDAP_OBJECT_CLASS_VIOLATION = 65 //对象类冲突

LDAP_NOT_ALLOWED_ON_NON_LEAF = 66 //不允许在非叶结点执行此操作

LDAP_NOT_ALLOWED_ON_RDN = 67 //不允许对RDN执行此操作

LDAP_ENTRY_ALREADY_EXISTS = 68 //Entry已存在

LDAP_OBJECT_CLASS_MODS_PROHIBITED = 69 //禁止更改对象类

LDAP_AFFECTS_MULTIPLE_DSAS = 71 //null

LDAP_OTHER = 80 //其它
```

