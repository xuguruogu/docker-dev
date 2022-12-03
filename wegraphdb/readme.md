```shell
# start container for building
docker run --network host -v $(pwd):/ccache/ -v $(pwd):/data/ -e USER_NAME=$(id -un) -e USER_ID=$(id -u) -it --rm wegraphdb/ci:centos8-dev-clang15
docker run --network host -v $(pwd):/ccache/ -v $(pwd):/data/ -e USER_NAME=$(id -un) -e USER_ID=$(id -u) -it --rm wegraphdb/ci:centos8-dev-gcc11
```
