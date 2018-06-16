# 倒排索引
> es创建索引事，根据mapping里设定，取得分词器，对每个文档(document)的每个字段(field)进行分词,对分词后的每个单词(term)建立倒排索引，存到硬盘。倒排索引建立的是term--document的映射关系，即根据单词查document

#### index：该属性控制字段是否编入索引被搜索，该属性共有三个有效值：analyzed、no和not_analyzed：

* analyzed：表示该字段被分析，编入索引，产生的token能被搜索到；
* not_analyzed：表示该字段不会被分析，使用原始值编入索引，在索引中作为单个词；
* no：不编入索引，无法搜索该字段；
* 其中analyzed是分析，分解的意思，默认值是analyzed，表示将该字段编入索引，以供搜索。

# 正排索引
> 根据文档查单词，建立文档跟单词的对应关系，即这个文档中包含哪些词。** 主要用于排序，聚合的字段 **

* doc_value 用于存储正排索引是数据结构，是默认应用。对于string类型不分词的(index: not_analyzed)和其他字段有效。建立document到field的对应关系。创建索引(index-time)的时候创建，数据保存在硬盘
* fielddata 用于string类型的分词(index: analyzed)的场景，建立document到term的对应关系，保存在jvm内存。该数据结构在字段第一次执行聚合、排序时生成。从硬盘上读取倒排索引的每个段（Segment），建立文档和倒转词（Term）的关系，并将其存储在JVM堆内存中。加载字段数据的过程是非常消耗IO资源的，一旦被加载，就被存储在内存中，直到段的生命周期结束

> loading属性控制fielddata加载到内存的时机，可能的值是lazy，eager和eager_global_ordinals，默认值是lazy。

    lazy：fielddata只在需要时加载到内存，默认情况下，在第一次搜索时，fielddata被加载到内存中；但是，如果查询一个非常大的索引段（Segment），lazy加载方式会产生较大的时间延迟。
    eager：在倒排索引的段可用之前，其数据就被加载到内存，eager加载方式能够减少查询的时间延迟，但是，有些数据可能非常冷，以至于没有请求来查询这些数据，但是冷数据依然被加载到内存中，占用紧缺的内存资源。
    eager_global_ordinals：按照global ordinals积极把fielddata加载到内存。
> ES_HEAP_SIZE 环境变量控制分配给JVM进程的堆内存（Heap Memory）大小，顺排索引（fielddata）的数据存储在堆内存（Heap Memory）中。

```
{  
   "settings":{  
      "number_of_shards":5,
      "number_of_replicas":0,
      "index":{
        "analysis":{
            "analyzer":{
                "default":{
                    "type":"standard"
                    ,"stopwords":"_english_"
                }
            }
        }
      }
   },
   "mappings":{  
      "events":{  
         "dynamic":"false",
         "properties":{  
            "eventid":{  
               "type":"long",
               "store":false,
               "index":"not_analyzed"
            },
            "eventname":{  
               "type":"string",
               "store":false,
               "index":"analyzed",
               "fields":{  
                  "raw":{  
                     "type":"string",
                     "store":false,
                     "index":"not_analyzed"
                  }
               }
            }
         }
      }
   }
}
```

## 数据类型 keyword,text
> keyword,text都是String，
> keyword是不需要分词的，存储为倒排索引
> text需要分词，然后存储为倒排索引

## 查询term,match
* term是不用分词器，直接用原词查询
* match是要经过分词器分词，然后再去查询，经过分词器，会经过过滤器，如果用starnd分词器，会有lowcase过滤器，会把大写字母都小写，然后再去倒排索引里查询

## best parctise
* 需要分词查询的字段text，否则用keyword
* 需要要排序、聚合的字段开启doc_value,否则不要开启，占据磁盘空间
* 对于分词的text，不要排序聚合，会引起fielddata异常
* mapping只能被增加，不能修改，如果要修改，只能删掉重建