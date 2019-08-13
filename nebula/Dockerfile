FROM centos:7
MAINTAINER xuguruogu

RUN set -ex; \
    sed -i 's/tsflags=nodocs//g' /etc/yum.conf; \
    yum install -y epel-release centos-release-scl scl-utils yum-plugin-copr; \
    yum install -y vim-enhanced lsof tcpdump zsh wget curl telnet git git-lfs man which net-tools iotop dstat ascii sudo; \
    yum install -y devtoolset-7-toolchain; \
    yum install -y readline readline-devel openssl openssl-devel bison unzip gperf; \
    yum install -y autoconf autoconf-archive automake libtool cmake; \
    yum install -y ncurses ncurses-devel; \

    mkdir -p /tmp/build && cd /tmp/build; \

    wget https://dl.bintray.com/boostorg/release/1.68.0/source/boost_1_68_0.tar.gz; \
    tar vxzf boost_1_68_0.tar.gz; \
    pushd boost_1_68_0; \
    scl enable devtoolset-7 "./bootstrap.sh --without-libraries=python,mpi,graph,graph_parallel --without-icu"; \
    scl enable devtoolset-7 "./b2 cxxflags=-fPIC cflags=-fPIC variant=release link=static threading=multi runtime-link=static install"; \
    popd; \

    wget http://web.mit.edu/kerberos/dist/krb5/1.17/krb5-1.17.tar.gz; \
    tar vxzf krb5-1.17.tar.gz; \
    pushd krb5-1.17/src; \
    scl enable devtoolset-7 "./configure cxxflags=-fPIC cflags=-fPIC --enable-static --disable-shared"; \
    scl enable devtoolset-7 "make && make install"; \
    popd; \

    wget http://download.savannah.nongnu.org/releases/libunwind/libunwind-1.3.1.tar.gz; \
    tar vxzf libunwind-1.3.1.tar.gz; \
    pushd libunwind-1.3.1; \
    scl enable devtoolset-7 "./configure --disable-tests --disable-shared --enable-static"; \
    scl enable devtoolset-7 "make && make install"; \
    popd; \

    yum clean all; \

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