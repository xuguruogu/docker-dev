FROM xuguruogu/dev:base
MAINTAINER xuguruogu

RUN set -ex && \
    yum copr enable -y vbatts/bazel && \
    yum install -y bazel && \
    yum clean all -y && \
    yum autoremove -y

# scl enable devtoolset-7
SHELL [ "/usr/bin/scl", "enable", "devtoolset-7" ]
RUN mkdir -p /tmp/pkg
COPY simple2pmi.c.origin /tmp/pkg
COPY simple2pmi.c.yard /tmp/pkg

# install mpich
RUN set -ex && \
    pushd /tmp/pkg && \
    wget https://www.mpich.org/static/downloads/3.2.1/mpich-3.2.1.tar.gz && \
    tar -zxvf mpich-3.2.1.tar.gz && \
    (cd mpich-3.2.1 && cp ../simple2pmi.c.origin src/pmi/pmi2/simple/simple2pmi.c && ./configure --prefix=/opt/mpich-3.2.1 --with-pic --enable-static --disable-shared --disable-fortran --disable-mpi-fortran --enable-mpi-thread-mutliple && make -j`nproc` && make install) && \
    (cd mpich-3.2.1 && cp ../simple2pmi.c.yard src/pmi/pmi2/simple/simple2pmi.c && ./configure --prefix=/opt/mpich-yard-3.2.1 --with-pic --enable-static --disable-shared --disable-fortran --disable-mpi-fortran --enable-mpi-thread-mutliple && make -j`nproc` && make install) && \
    rm -rf mpich-3.2.1.tar.gz mpich-3.2.1 && \
    popd

ENV CC /usr/local/bin/mpicc

# clean pkg
RUN rm -rf /tmp/pkg/

CMD [ "/usr/bin/scl", "enable", "devtoolset-7", "/bin/bash"]