# Column

### args
* label
* Type: String,Inetger
* primary_key=True
* default: default=12(指定值),default=gen_id(跟函数)
* onupdate=datetiem.datetime.now
* Sequence('cart_id_seq', metadata=meta)
  
### Sequence加上meta，可以保证每次table craete/drop的时候，sequence也跟着一起create/drop

```
import datetime

t = Table("mytable", meta,
    Column('id', Integer, primary_key=True),

    # define 'last_updated' to be populated with datetime.now()
    Column('last_updated', DateTime, onupdate=datetime.datetime.now),
)
```