# POST

## requests

```python
import requests#导入request模块
import json#导入json模块
url = 'https://httpbin.org/post'
body= {"pw":'1011634093@qq.com',"un":"password"}
data_json = json.dumps(body)#转化成json类型
headers = {"Content-type":"application/json"}
response = requests.post(url=url,data=data_json,headers=headers)
print(response.status_code)
print(response.text)
```



## urllib2 (python2.7)

```python
request = urllib2.Request(stateupdateapi)
request.add_header("Content-Type", "application/json")
body = {"key":"1","value":"2"}
ret = urllib2.urlopen(request,json.dumps(body)).read()
print(ret)
```

