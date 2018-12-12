

* hostvars 可以让你调用其他host的变量和facts,  即使你没有在这个机器上执行过playbook, 你仍然可以访问变量, 但是不能访问facts. 
```
{{ hostvars['test.example.com']['ansible_distribution'] }}
```
* group_names 当前host所在的group的组名列表.   包括其父组
* groups 所有组包括组中的hosts
* inventory_hostname 配置在inventory文件中当前机器的hostname
* play_hosts 执行当前playbook的所有机器的列表
* inventory_dir inventory文件的路径
* inventory_file inventory文件的路径和文件名
* role_path 当前role的路径


## inventory 定义变量
> NOTE inventory里定义的变量，不支持变量引用
```
all: 
  hosts: 
    host-1: 
      ansible_ssh_host: 
      ansible_ssh_pass:  
  vars: 
    a: 1
    b: 2
vars: 
  c: 3
  d: 4
# a,b是host-1主机的变量，c,d是所有主机的变量
```

## playbook 定义变量
1. vars  定义变量
2. vars_files  引用外面变量文件,可以进行变量引用

## set_fact
```
set_fact: 
  a: 1
  b: 2
```