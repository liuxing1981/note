
## 安装pip3
```
sudo apt-get install python3
sudo apt-get install python3-pip
```

## Win10
```
python3 -m pip install -U pip
```

## 配置阿里镜像
```
vi ~/.pip/pip.conf

[global]
index-url = http://mirrors.aliyun.com/pypi/simple/
proxy = http://135.245.48.34:8000

[install]
trusted-host=mirrors.aliyun.com
```

## install pypy pip
```
wget https://bootstrap.pypa.io/get-pip.py
pypy get-pip.py
pypy -m install openpyxl

```

## requirements.txt
#### 生成所有包，包括依赖包，适合虚拟环境
```
pip freeze > requirements.txt
```

#### 推荐使用pipreq
```
# 安装
pip install pipreqs
# 在当前目录生成
pipreqs . --encoding=utf8 --forces
```

#### 安装requirements.txt
```
pip install -r requirements.txt
```
