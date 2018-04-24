#!/bin/bash
NAME=note
docker rm -fv $NAME 2>/dev/null
docker run --name $NAME -d -p 4000:4000 \
        -v `pwd`:/root/project \
	liuxing1981/gitbook

echo "gitbook note local start at http://localhost:4000" 
