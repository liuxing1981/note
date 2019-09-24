# PEM--Privacy Enhanced Mail

### **X.509**证书标准的一种编码

以"-----BEGIN..."开头, "-----END..."结尾,内容是BASE64编码

```bash
openssl x509 -in certificate.pem -text -noout
```



# DER

### **X.509**证书标准的一种编码

辨别编码规则 (DER) 可包含所有私钥、公钥和证书。它是大多数浏览器的缺省格式，并按 ASN1 DER 格式存储。它是无报头的 － **PEM 是用文本报头包围的 DER**

Java和Windows服务器偏向于使用这种编码格式

```bash
openssl x509 -in certificate.der -inform der -text -noout
```



# 证书编码的转换

**PEM转为DER** 

```bash
openssl x509 -in cert.crt -outform der -out cert.der
```

**DER转为PEM** 

```java
openssl x509 -in cert.crt -inform der -outform pem -out cert.pem
```



# **CRT** -- linux系统

 CRT应该是certificate的三个字母,其实还是证书的意思,常见于*NIX系统,有可能是PEM编码,也有可能是DER编码,大多数应该是PEM编码



# **CER** -- windows系统

还是certificate,还是证书,常见于Windows系统,同样的,可能是PEM编码,也可能是DER编码,大多数应该是DER编码.证书中没有私钥，**DER 编码二进制格式的证书文件**



# **KEY** -- 公钥或者私钥

通常用来存放一个公钥或者私钥,并非X.509证书,编码同样的,可能是PEM,也可能是DER.
查看KEY的办法:

```bash
openssl rsa -in mykey.key -text -noout
#DER格式
openssl rsa -in mykey.key -text -noout **-inform der**
```



# CSR -- 证书签名请求

Certificate Signing  Request,即证书签名请求,这个并不是证书,而是向权威证书颁发机构获得签名证书的申请,其核心内容是一个公钥(当然还附带了一些别的信息),在生成这个申请的时候,同时也会生成一个私钥,私钥要自己保管好.做过iOS  APP的朋友都应该知道是怎么向苹果申请开发者证书的吧

```bash
openssl req -noout -text -in my.csr 
```

