# 分词器
* 标准分词器 standard
* 简单分词器 simple
* 空格分词器
* 语言分词器
* IK中文分词器：https://github.com/medcl/elasticsearch-analysis-ik
* 拼音分词器：https://github.com/medcl/elasticsearch-analysis-pinyin

```
进入elasticsearch安装目录/plugins
mkdir pinyin
cd pinyin
重启es节点

PUT my_index/_settings 
"index" : 
{
	"number_of_shards": "3",
	"number_of_replicas": "1",
	"analysis": {
		"analyzer": {
			"default": {
				"tokenizer": "ik_max_word"
			},
			"pinyin_analyzer": {
				"tokenizer": "my_pinyin"
			}
		},
		"tokenizer": {
			"my_pinyin": {
				"keep_separate_first_letter": "false",
				"lowercase": "true",
				"type": "pinyin",
				"limit_first_letter_length": "16",
				"keep_original": "true",
				"keep_full_pinyin": "true"
			}
		}
	}
}
```

```
PUT my_index/index_type/_mapping
"ep": {
	"_all": {
		"analyzer": "ik_max_word"
	},
	"properties": {
		"name": {
			"type": "text",
			"analyzer": "ik_max_word",
			"include_in_all": true,
			"fields": {
				"pinyin": {
					"type": "text",
					"term_vector":"with_positions_offsets",
					"analyzer":"pinyin_analyzer",
					"boost": 10.0
				}
			}
		}
	}
}
```