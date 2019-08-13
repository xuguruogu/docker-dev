FROM centos:7
MAINTAINER xuguruogu

RUN set -ex && \
    sed -i 's/tsflags=nodocs//g' /etc/yum.conf && \
    yum install -y epel-release centos-release-scl scl-utils yum-plugin-copr && \
    yum install -y vim-enhanced lsof tcpdump zsh wget curl telnet git git-lfs man which net-tools iotop dstat ascii sudo && \
    yum install -y autoconf autoconf-archive automake libtool cmake gdb make bazel && \
    yum install -y gcc gcc-c++ glibc-static libstdc++-static && \
    yum install -y devtoolset-7-toolchain && \
    yum install -y java-1.8.0-openjdk-devel && \
    yum install -y zlib-devel && \
    yum clean all

RUN set -ex && \
    curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true

RUN set -ex && \
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \
    echo 'export JAVA_HOME=\$(readlink -f /usr/bin/java | sed \"s:bin/java::\")' > ~/.zprofile && \
    chsh -s /bin/zsh

#    scl enable devtoolset-7 bash
SHELL [ "/usr/bin/scl", "enable", "devtoolset-7"]

RUN mkdir /data
VOLUME /data
WORKDIR /data
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
CMD ["/bin/zsh"]