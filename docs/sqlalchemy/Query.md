# Query

Here’s a rundown of some of the most common operators used in filter():

### equals:
```
query.filter(User.name == 'ed')
```

### not equals:
```
query.filter(User.name != 'ed')
```

### LIKE:
```
query.filter(User.name.like('%ed%'))
```

### ILIKE (case-insensitive LIKE):
```
query.filter(User.name.ilike('%ed%'))
```

### IN:
```
query.filter(User.name.in_(['ed', 'wendy', 'jack']))
# works with query objects too:
query.filter(User.name.in_( session.query(User.name).filter(User.name.like('%ed%'))))
```

### NOT IN:
```
query.filter(~User.name.in_(['ed', 'wendy', 'jack']))
```

### IS NULL:
```
query.filter(User.name == None)

# alternatively, if pep8/linters are a concern
query.filter(User.name.is_(None))
```

### IS NOT NULL:
```
query.filter(User.name != None)
# alternatively, if pep8/linters are a concern
query.filter(User.name.isnot(None))
```

### AND:
```
# use and_()
from sqlalchemy import and_
query.filter(and_(User.name == 'ed', User.fullname == 'Ed Jones'))
```

### OR
```
# or send multiple expressions to .filter()
query.filter(User.name == 'ed', User.fullname == 'Ed Jones')

# or chain multiple filter()/filter_by() calls
query.filter(User.name == 'ed').filter(User.fullname == 'Ed Jones')
```

### MATCH
```
query.filter(User.name.match('wendy'))
```

### One()
> 查询所有的数据，并且仅对只有一条的数据返回，多条或没有 都报错

### One_or_none()
> 同one，但是多条数据报错，没有数据返回none，不报错

### Scalar()
> 同one，返回第一条的第一列

### text()
> 用于写纯sql,如果是select语句，需要放在from_statement里
```
stmt = text("SELECT name, id FROM users where name=:name")
stmt = stmt.columns(User.name, User.id)  # 指定返回列
session.query(User.id, User.name).from_statement(stmt).params(name='ed').all()
[(1, u'ed')]
```

### count()
```
session.query(User).filter(User.name.like('%ed')).count()
session.query(func.count(User.name), User.name).group_by(User.name).all()
# 如果我们用用户主键直接表示计数，select_from()的用法可以删除
session.query(func.count('*')).select_from(User).scalar()
session.query(func.count(User.id)).scalar()
```