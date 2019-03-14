# Use xml.tree.cElement
```
import xml.etree.cElementTree as ET
tree = ET.parse('country.xml')
root = tree.getroot()
ET.dump(root)   #dump xml 结构到console
```

## 一个node属性
* node.text 获取文本
* node.tag
* node.get('attr') 获取attr的属性
* node.attrib 获取所有的属性(dict )
* del node.attrib[key]   # 删除对应的属性
* remove() 删除元素
* keys() 属性所有key
* items() 属性 值的dict
```
  print(root.find('.//neighbor').attrib)
  #{'name': 'Austria', 'direction': 'E'}
```

## 一个node的方法,支持xpath
* iter('node') 获取一个迭代器，查找所有名字是node的节点
* iterfind('node') 返回一个迭代器
* itertext()  返回一个当前node所有子元素的text的迭代器
```
for rank in root.findall('.//rank'):
    for text in rank.itertext():
        print(text)

for rank in root.findall('.//rank'):
    print(rank.text)
返回相同结果
```
* find('node') 在直接子节点中找到第一个node
* findall('node') 在直接子节点中找到所有的node
* findtext('node') 返回node节点的text

>NOTE: iter不支持xpath。 如果findall使用xpath，就跟iter一样，例如
root.findall('.//rank')
root.iter('rank')
返回相同node
iter返回迭代器，findall返回list
```
# 返回相同结果
print(root.findtext('.//year'))
print(root.find('.//year').text)
```

