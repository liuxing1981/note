#!/bin/bash
NAME=note
docker rm -fv $NAME 2>/dev/null
docker run --name $NAME -d -p 4000:4000 \
        -e GIT_URL=git@github.com:liuxing1981/${NAME}.git \
	-v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
	-v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
	liuxing1981/gitbook

echo "gitbook note start at http://localhost:4000" 
