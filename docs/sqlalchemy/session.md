# session

## sessionmake
> sessionmake 是一个session factory，每次根据相同的配置，new出一个session
> sessionmake 最好是用engine的配置，这样每个session都会有engine的配置

## When you write your application, place the sessionmaker factory at the global level
```
engine = create_engine('postgresql://scott:tiger@localhost/')

# create a configured "Session" class
Session = sessionmaker(bind=engine)

# create a Session
session = Session()
```

## 配置一个已存在的sessionmake
```
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine

# configure Session class with desired options
Session = sessionmaker()

# later, we create the engine
engine = create_engine('postgresql://...')

# associate it with our custom Session class
Session.configure(bind=engine)

# work with the session
session = Session()
```

## 得到一个特别的session
> 如果要创建一个特别的session，不用sessionmake里的默认参数，可以这样做
```
engine = create_engine('postgresql://scott:tiger@localhost/')
# at the module level, the global sessionmaker,
# bound to a specific Engine
Session = sessionmaker(bind=engine)

# later, some unit of code wants to create a
# Session that is bound to a specific Connection
conn = engine.connect()
session = Session(bind=conn)
```