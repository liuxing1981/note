#########################################################################
# File Name: sync_vim.sh
# Author: luis
# mail: xing.1.liu@nokia-sbell.com
# Created Time: 2018年12月09日 星期日 11时07分13秒
#########################################################################
#!/bin/bash

sync_local(){
    /usr/bin/expect <<-EOF
        spawn sudo cp -r $1 /root/
        expect "*assword"
        send "$2\r"
        expect eof
    EOF
    ls -l /root/`basename $1`
}

sync_remote() {
    /usr/bin/expect <<-EOF
        spawn scp -r $4 $1@$2:/home/$1
        expect {
                "(yes/no)?"  {
                                send "yes\r"
                                expect　"password"  { send "$3\r"}
                             }
                 "password"
                            {
                                send "$3\r"
                            }
        }
        expect "100%"
        expect eof
        EOF
}
sync_remote xliu074 135.242.137.120 xliu074 /home/luis/.vimrc
sync_remote happym 135.242.137.120 happym /home/luis/.vimrc
sync_local ~/.vimrc luis