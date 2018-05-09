# Chronyd 服务是代替ntpd的时间同步服务器

## Note
* chronyd与ntpd不能共存，只有一个可以存在
* centos7默认已经安装好chronyd了

## Install
```
For Ubuntu:

# apt install chrony

For RHEL or CentOS:

# yum install chrony

For SUSE:

# zypper install chrony
```

## Server Configure
```
    vim /etc/chronyd.conf

    server ntp1.aliyun.com
    server time1.aliyun.com
```
## other node
```
    vim /etc/chronyd.conf

    server controller
```
