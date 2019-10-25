FROM centos:7
MAINTAINER xuguruogu

RUN set -ex && \
    sed -i 's/tsflags=nodocs//g' /etc/yum.conf && \
    yum install -y epel-release centos-release-scl scl-utils yum-plugin-copr && \
    yum install -y vim-enhanced lsof tcpdump wget curl telnet git git-lfs psmisc subversion man which net-tools iotop dstat ascii sudo && \
    yum install -y autoconf autoconf-archive automake libtool cmake3 gdb make bazel && \
    yum install -y gcc gcc-c++ glibc-static libstdc++-static && \
    yum install -y devtoolset-7-toolchain && \
    yum install -y java-1.8.0-openjdk-devel && \
    yum install -y zlib-devel unzip numactl-devel && \
    yum clean all -y && \
    yum autoremove -y && \
    ln -s /usr/bin/cmake3 /usr/bin/cmake

RUN set -ex && \
    curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true

RUN mkdir /data
VOLUME /data
WORKDIR /data
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
CMD ["/bin/bash"]