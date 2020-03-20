
# Dockerized development environment

## Use

    docker run -v $(pwd):/data -e USER_NAME=$(id -un) -e USER_ID=$(id -u) -it --rm xuguruogu/dev/nebula:centos7

    docker run -v $(pwd):/data -e USER_NAME=$(id -un) -e USER_ID=$(id -u) -it --name base_dev xuguruogu/dev:base
    docker start -i base_dev
    docker exec -it -u $(id -u) base_dev /bin/bash

## Build
    docker build -t xuguruogu/dev/nebula:centos7 --network host -f Dockerfile.nebula.centos7 .
