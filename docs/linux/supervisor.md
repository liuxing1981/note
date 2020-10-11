## Supervisor

* /etc/supervisor.conf    主配置文件

  ```
  [include]
  files = /etc/supervisor.d/*.ini
  
  主配置文件里的这行表示包含哪些子配置文件，这里是ini文件，所以在/etc/supervisor.d/下面文件名必须是ini
  ```

  

  

* /etc/supervisor.d/your_service.conf         子配置文件，要运行的程序写在这里

```bash
[program:blog]
#脚本目录
directory=/opt/bin
#脚本执行命令
command=/usr/bin/python /opt/bin/test.py

#supervisor启动的时候是否随着同时启动，默认True
autostart=true
#当程序exit的时候，这个program不会自动重启,默认unexpected，设置子进程挂掉后自动重启的情况，有三个选项，false,unexpected和true。如果为false的时候，无论什么情况下，都不会被重新启动，如果为unexpected，只有当进程的退出码不在下面的exitcodes里面定义的
autorestart=false
#这个选项是子进程启动多少秒之后，此时状态如果是running，则我们认为启动成功了。默认值为1
startsecs=1

#脚本运行的用户身份 
user = test

#日志输出 
stderr_logfile=/tmp/blog_stderr.log 
stdout_logfile=/tmp/blog_stdout.log 
#把stderr重定向到stdout，默认 false
redirect_stderr = true
#stdout日志文件大小，默认 50MB
stdout_logfile_maxbytes = 20MB
#stdout日志文件备份数
stdout_logfile_backups = 20
```

在新增配置文件后，要使用`supervisorctl update`命令，使用此命令后会自动加载新的配置，并且启动该进程。

## command

```
supervisorctl status        //查看所有进程的状态
supervisorctl stop es       //停止es
supervisorctl start es      //启动es
supervisorctl restart       //重启es
supervisorctl update        //配置文件修改后使用该命令加载新的配置
supervisorctl reload        //重新启动配置中的所有程序
```



## Supervisor as systemd
```
vi /etc/systemd/system/supervisord.service

[Unit]
Description=supervisor
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/usr/bin/supervisord -c /etc/supervisord.conf
ExecStop=/usr/bin/supervisorctl shutdown
ExecReload=/usr/bin/supervisorctl reload
KillMode=process
Restart=on-failure
RestartSec=42s

[Install]
WantedBy=multi-user.target

systemctl enable supervisord
systemctl start supervisord
```