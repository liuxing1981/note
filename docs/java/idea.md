感谢 http://idea.lanyus.com/  的提供的方法！

具体操作如下：

  下载JetbrainsCrack-2.7-release-str.jar ，放在IDEA安装目录的bin 目录下

  修改idea.exe.vmoptions和idea64.exe.vmoptions，两个文件，用记事本打开后添加：

-javaagent:F:/hadoop/IDEA/bin/JetbrainsCrack-2.7-release-str.jar

也就是-javaagent: jar包的绝对路径

重新打开idea.exe ,在Activition Code 中复制：
```
ThisCrackLicenseId-{
"licenseId":"ThisCrackLicenseId",
"licenseeName":"idea",
"assigneeName":"",
"assigneeEmail":"idea@163.com",
"licenseRestriction":"For This Crack, Only Test! Please support genuine!!!",
"checkConcurrentUse":false,
"products":[
{"code":"II","paidUpTo":"2099-12-31"},
{"code":"DM","paidUpTo":"2099-12-31"},
{"code":"AC","paidUpTo":"2099-12-31"},
{"code":"RS0","paidUpTo":"2099-12-31"},
{"code":"WS","paidUpTo":"2099-12-31"},
{"code":"DPN","paidUpTo":"2099-12-31"},
{"code":"RC","paidUpTo":"2099-12-31"},
{"code":"PS","paidUpTo":"2099-12-31"},
{"code":"DC","paidUpTo":"2099-12-31"},
{"code":"RM","paidUpTo":"2099-12-31"},
{"code":"CL","paidUpTo":"2099-12-31"},
{"code":"PC","paidUpTo":"2099-12-31"}
],
"hash":"2911276/0",
"gracePeriodDays":7,

"autoProlongated":false}
```