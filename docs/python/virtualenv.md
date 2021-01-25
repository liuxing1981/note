## install
有2种虚拟环境，一种是python3自带的venv，一种是virtualevn
venv不太好用
```
# 如果需要使用virtualenv，需要独立安装
pip install virtualenv
```

## How to run
```
mkdir myproject
cd myproject
# create venv
virtualenv . --python=python3
source venv/bin/activate
```

## Run in bash or windows dos cmd
```
@echo off
cmd /k "cd Scripts & activate.bat & cd .. & pip install -r requirements.txt & pyinstaller -F Arithmetic_100.py -w & cd Scripts & deactivate.bat & cd .. & python zip.py"
```
