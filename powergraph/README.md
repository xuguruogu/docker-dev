
# Dockerized development environment

## Use

    docker run -v ${HOME}:/data -e USER_NAME=$(id -un) -e USER_ID=$(id -u) --rm -it xuguruogu/dev:powergraph

## Build
    
    docker build . -t xuguruogu/dev:powergraph
