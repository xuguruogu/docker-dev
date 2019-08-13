
# Dockerized development environment

## Use

    docker run -v ${HOME}:/data -e USER_NAME=$USER -e USER_ID=$(id -u $USER) --name $USER -it xuguruogu/dev:centos /bin/zsh

## Build
    
    docker build . -t dev:nebula