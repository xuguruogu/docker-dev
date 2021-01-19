
# Dockerized development environment

## Use

    docker run --cap-add sys_ptrace --network host -p2222:22 -v $(pwd):/data -e USER_NAME=$(id -un) -e USER_ID=$(id -u) -it --rm xuguruogu/dev/plato:centos7
    docker run --cap-add sys_ptrace --network host -p2222:22 -v $(pwd):/data -e USER_NAME=$(id -un) -e USER_ID=$(id -u) -it --rm xuguruogu/dev/base:centos7

    docker run -v $(pwd):/data -e USER_NAME=$(id -un) -e USER_ID=$(id -u) -it --name base_dev xuguruogu/dev/base:centos7
    docker start -i base_dev
    docker exec -it -u $(id -u) base_dev /bin/bash

## Build
    docker build -t xuguruogu/dev/base:centos7 --network host -f Dockerfile.base.centos7 .
    docker build -t xuguruogu/dev/plato:centos7 --network host -f Dockerfile.plato.centos7 .
