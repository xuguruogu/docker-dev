
# Dockerized development environment

## Use

    docker run -v ${HOME}:/data -e USER_NAME=$(id -un) -e USER_ID=$(id -u) --rm -it xuguruogu/dev:base

## Build
    
    docker build -t xuguruogu/dev:base -f Dockerfile.base .
    docker build -t xuguruogu/dev:plato -f Dockerfile.plato .
    docker build -t xuguruogu/dev:nebula -f Dockerfile.nebula .
    docker build -t xuguruogu/dev:powergraph -f Dockerfile.powergraph .
