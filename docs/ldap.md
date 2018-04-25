# LDAP
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
```
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