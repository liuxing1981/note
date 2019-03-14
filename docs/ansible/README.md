# Install latest release
## method1
```
sudo apt-get update
sudo apt-get install software-properties-common
curl -sL "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x93C4A3FD7BB9C367" | sudo apt-key add
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible
```

## method 2
```
vi /etc/apt/sources.list
deb http://ppa.launchpad.net/ansible/ansible-2.7/ubuntu bionic main 
deb-src http://ppa.launchpad.net/ansible/ansible-2.7/ubuntu bionic main 
```