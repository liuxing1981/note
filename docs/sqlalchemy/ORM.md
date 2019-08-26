# ORM

## class
> 通过 decleative system进行mapping
> 所有的class的__table__属性，存放mapping的信息
> class自动实现一个keyword关键字的__init__方法
> primary key的字段，在实例化的时候，自动赋值，不会报错

## session.flush()
> 当要查询的时候，会自动调用一个flush，把缓存的数据都存到数据库
```
session.add(car)
session.flush()   # query之前自动调用flush
session.query(Car)
```