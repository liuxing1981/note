#########################################################################
# File Name: view.sh
# Author: xliu074
# mail: xing.1.liu@nokia-sbell.com
# Created Time: 2019-08-26 18:14
#########################################################################
#!/bin/bash
#./commit.sh
NAME=note
EDIT_URL=http://10.67.27.139/luis/note/edit/master
VOL=/home/xliu074/docker/$NAME
sed -i "s#\"base\":.*#\"base\": \"$EDIT_URL\",#" book.json
docker rm -fv $NAME 2>/dev/null
rm -rf $VOL
#docker volume create note
[ -z "$1" ] && arg=github || arg=$1
case $arg in
    debug)
    docker run --name $NAME -it -p 4000:4000 \
        -e GIT_URL=git@github.com:liuxing1981/${NAME}.git \
        -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
        -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
        -v /root/project \
        liuxing1981/gitbook sh
    echo "gitbook in debug mode"
    ;;
    local)
    rm -rf book.json
    docker run --name $NAME -d -p 4000:4000 \
        -v `pwd`:/root/project \
        liuxing1981/gitbook
    echo "gitbook in local view mode"
    ;;
    github)
	if echo $HTTPS_USER && echo $HTTPS_PASS;then
		docker run --name $NAME -d -p 4000:4000 \
			-e HTTPS_URL=http://10.67.27.139/luis/${NAME} \
			-e HTTPS_USER=$HTTPS_USER \
			-e HTTPS_PASS=$HTTPS_PASS \
			-v $VOL:/root/project \
			liuxing1981/gitbook
		echo "gitbook in github view mode,http://localhost:4000"
	else
		echo "Please set HTTPS_USER as your github username:  HTTPS_USER=liuxing"
		echo "Please set HTTPS_PASS as your github password:  HTTPS_PASS=password"
		exit 2
	fi
    ;;
	*)
		echo "other args!";;
esac
docker logs -f $NAME
