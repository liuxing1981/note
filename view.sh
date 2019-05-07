#!/usr/bin/env bash
./commit.sh
NAME=note
docker rm -fv $NAME 2>/dev/null
#docker volume create note
[ -z "$1" ] && arg=local
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
    *)
    docker run --name $NAME -d -p 4000:4000 \
        -e GIT_URL=git@github.com:liuxing1981/${NAME}.git \
	-v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
	-v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
	-v /root/project \
	liuxing1981/gitbook
    echo "gitbook in github view mode,http://localhost:4000"
    ;;
esac
docker logs -f note
