FROM centos:latest
MAINTAINER xuguruogu

RUN set -ex; \
    sed -i 's/tsflags=nodocs//g' /etc/yum.conf; \
    yum update -y; \
    yum install -y epel-release centos-release-scl scl-utils yum-plugin-copr; \
    yum copr enable -y vbatts/bazel; \
    yum install -y gcc gcc-c++ glibc-static libstdc++-static make gdb cmake autoconf-archive \
    bazel devtoolset-8-gcc-c++ devtoolset-8-libubsan devtoolset-8-libasan devtoolset-8-libatomic \
    vim-enhanced lsof tcpdump zsh wget telnet git git-lfs man which net-tools iotop dstat ascii \
    flex gperf libtool bison unzip krb5 openssl-devel libunwind-devel numactl-devel hwloc-devel \
    libpciaccess-devel cryptopp-devel libxml2-devel gnutls-devel lz4-devel protobuf-devel protobuf-compiler \
    yaml-cpp-devel ncurses-devel readline-devel python-devel c-ares-devel stow systemtap-sdt-devel \
    boost-devel boost-static lksctp-tools-devel xfsprogs-devel java-latest-openjdk-devel ragel ninja-build \
    rh-mongodb36-boost-devel sudo; \
    yum clean all; \
    update-alternatives --auto java;

RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64"; \
    chmod +x /usr/local/bin/gosu; \
    gosu nobody true;

RUN set -ex; \
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh; \
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc; \
    echo 'export JAVA_HOME=\$(readlink -f /usr/bin/java | sed \"s:bin/java::\")' > ~/.zprofile; \
    chsh -s /bin/zsh;

RUN mkdir /data
VOLUME /data
WORKDIR /data
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]