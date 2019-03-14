# 在idea中运行ok，maven打包后乱码
```
运行命令是加上-Dfile.encoding=UTF-8
java -jar -Dfile.encoding=UTF-8 anniversary-1.0.jar
```
```
添加环境变量
JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 
```

