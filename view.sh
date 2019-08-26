#########################################################################
# File Name: view.sh
# Author: xliu074
# mail: xing.1.liu@nokia-sbell.com
# Created Time: 2019-08-26 18:14
#########################################################################
#!/bin/bash
#./commit.sh
NAME=note
docker rm -fv $NAME 2>/dev/null
#docker volume create note
[ -z "$1" ] && arg=local || arg=$1
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
	if echo $GIT_USER && echo $GIT_PASS;then
		docker run --name $NAME -d -p 4000:4000 \
			-e GIT_URL=https://github.com/liuxing1981/${NAME}.git \
			-e GIT_USER=$GIT_USER \
			-e GIT_PASS=$GIT_PASS \
			-v /root/project \
			liuxing1981/gitbook
		echo "gitbook in github view mode,http://localhost:4000"
	else
		echo "Please set GIT_USER as your github username:  GIT_USER=liuxing"
		echo "Please set GIT_PASS as your github password:  GIT_PASS=password"
		exit 2
	fi
    ;;
	*)
		echo "other args!";;
esac
docker logs -f note

