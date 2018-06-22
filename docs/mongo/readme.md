## How to start
```
cat docker-compose.yaml
version: '3.1'
services:
  mongo:
    image: mongo
    restart: always
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: root

  mongo-express:
    image: mongo-express
    restart: always
    ports:
      - 8081:8081
    environment:
      ME_CONFIG_MONGODB_ADMINUSERNAME: root
      ME_CONFIG_MONGODB_ADMINPASSWORD: root
```

## How to login
```
docker exec -it mongo mongo localhost:27017/admin -uroot -proot

```

## find
```
db.col.find().pretty()
db.col.findOne()
# and 
db.col.find({key1:value1, key2:value2}).pretty()

# or
db.col.find(
   {
      $or: [
         {key1: value1}, {key2:value2}
      ]
   }
).pretty()

# 查找后返回指定的键值
db.col.find(query, {title: 1, by: 1}) // inclusion模式 指定返回的键，不返回其他键
db.col.find(query, {title: 0, by: 0}) // exclusion模式 指定不返回的键,返回其他键

db.col.find(query, {_id:0, title: 1, by: 1})  //隐藏_id，只返回指定的by字段

db.col.find({likes : {$lte : 150}})
```
## $type
类型 	数字 	备注
Double 	1 	 
String 	2 	 
Object 	3 	 
Array 	4 	 
Binary data 	5 	 
Undefined 	6 	已废弃。
Object id 	7 	 
Boolean 	8 	 
Date 	9 	 
Null 	10 	 
Regular Expression 	11 	 
JavaScript 	13 	 
Symbol 	14 	 
JavaScript (with scope) 	15 	 
32-bit integer 	16 	 
Timestamp 	17 	 
64-bit integer 	18 	 
Min key 	255 	Query with -1.
Max key 	127

```
db.col.find({"title" : {$type : 2}})
db.col.find().limit(5)
db.col.find({},{"title":1,_id:0}).limit(1).skip(1)
```

## sort
```
db.col.find().sort({KEY:1})   // 1=升序 -1=降序
```

## index
```
db.col.createIndex({key1: 1, key2: -1}, {background: true})  // 1=升序，-1=降序  后台运行
```

```
db.collection.update(
   <query>,
   <update>,
   {
     upsert: <boolean>,
     multi: <boolean>,
     writeConcern: <document>
   }
)

db.inventory.deleteMany({ status : "A" })
db.inventory.deleteOne( { status: "D" } )
# remove is deprecated
db.collection.remove(
   <query>,
   {
     justOne: <boolean>,
     writeConcern: <document>
   }
)
```

## repset
```
mongod --port 27017 --dbpath "D:\set up\mongodb\data" --replSet rs0
```

## 全文索引
```
db.posts.createIndex({post_text:"text"})
db.posts.find({$text:{$search:"runoob"}})
```

## 正则
```
db.posts.find({post_text:/runoob/i})
```

## Replication in MongoDB（数据备份）
> 多个mongo实例组成一个repla set，形成主从节点，primary负责整个repla set写，slave负责同步数据做冗余备份，提供读操作。
> 主节点把数据变化信息写入oplog，然后在从节点上回放
> arbiter 是一个mongo实例，但是不存放数据，只是负责各个node的心跳与选举。如果有偶数个node，可以增加一个arbiter，让选举的node变为奇数个，以便获取选举结果。arbiter对硬件没有要求，就是凑一个奇数个node，
```
  Do not run an arbiter on systems that also host the primary or the secondary members of the replica set
```
**这是一个独立的node，不要运行在任何主从host上**
> 最好提供3个节点，1主2从，或者1主 1从 1个arbiter  
> but replica sets with at least three data-bearing members offer better redundancy.

## priority 0
> 配置在从节点上，这个选项表示 一个node不会成为主节点，也不会参加选举

## sharding
> 用于负载均衡，把一个collection的数据根据sharding key平均分布到各个sharding服务器上
> 对于空的collection，会在sharding key上自动建立索引，对于非空的collection，需要在sharding key上手动建立索引