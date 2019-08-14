FROM xuguruogu/dev:base
MAINTAINER xuguruogu

RUN set -ex && \
    yum install -y bazel && \
    yum clean all

RUN mkdir -p /tmp/pkg

# install mpich
RUN set -ex && \
    pushd /tmp/pkg && \
    wget http://www.mpich.org/static/downloads/3.3.1/mpich-3.3.1.tar.gz && \
    tar -zxvf mpich-3.3.1.tar.gz && \
    (cd mpich-3.3.1 && ./configure --with-pic --enable-static --disable-shared --disable-fortran --disable-mpi-fortran --enable-mpi-thread-mutliple && make -j`nproc` && make install) && \
    rm -rf mpich-3.3.1.tar.gz mpich-3.3.1 && \
    popd

ENV CC /usr/local/bin/mpicc

# clean pkg
RUN rm -rf /tmp/pkg/