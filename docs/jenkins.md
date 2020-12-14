## Jenkins Job 创建

```
curl -X POST http://localhost:8080/jenkins/createItem?name=Justatest  --user dongwuming:dongwuming --data-binary "@justatest.config.xml" -H "Content-Type:text/xml"
```

Jenkins Job 禁用

```
curl -X POST http://localhost:8080/jenkins/job/Justatest/disable  --user dongwuming:dongwuming
```

Jenkins Job 启用

```
curl -X POST http://localhost:8080/jenkins/job/Justatest/enable --user dongwuming:dongwuming
```

Jenkins Job 删除

```
curl -X POST http://localhost:8080/jenkins/job/Justatest/doDelete --user dongwuming:dongwuming
```

Jenkins Job 获取项目描述

```
curl -X GET http://localhost:8080/jenkins/job/Justatest/description --user dongwuming:dongwuming
```

Jenkins Job 获取配置文件

```
curl -X GET http://localhost:8080/jenkins/job/Justatest/config.xml --user dongwuming:dongwuming
```

Jenkins Job 触发SCM检查

```
curl -X GET http://localhost:8080/jenkins/job/Justatest/polling --user dongwuming:dongwuming
```

Jenkins Job 普通触发

```
curl -X GET http://localhost:8080/jenkins/job/Justatest/build --user dongwuming:dongwuming
```

Jenkins Job 带参数触发

```bash
remotely trigger
设置一个token，带着token请求

curl -X POST http://localhost:8080/jenkins/job/Test123/buildWithParameters?branch_name=master --user dongwuming:dongwuming
```

## Jenkins cli-jar
### export job
```
java -jar jenkins-cli.jar -s http://10.67.34.236:8080/ get-job NREG_Auto_VTK > NREG_Auto_VTK.job
```

### import job
```
java -jar jenkins-cli.jar -s http://10.67.30.56:8080/ -auth root:admin create-job NREG_Auto_VTK < NREG_Auto_VTK.job
```
### reload config from jenkins gui
```
Manage Jenkins-->Reload Configuration from Disk
```
