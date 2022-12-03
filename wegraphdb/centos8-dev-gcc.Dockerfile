FROM centos:8

RUN rm -rf /etc/yum.repos.d/CentOS-*
COPY ./centos8_base.repo /etc/yum.repos.d/CentOS-Base.repo
COPY ./install-dependencies.sh /usr/local/bin/install-dependencies.sh
RUN set -ex && \
    /usr/local/bin/install-dependencies.sh && \
    dnf autoremove -y && \
    dnf clean all

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0
ENV PATH /usr/lib/ccache:${PATH}
ENV CCACHE_BASEDIR /ccache
ENV XDG_CACHE_HOME /ccache
ENV CCACHE_DIR /ccache/.ccache
ENV CCACHE_COMPILERCHECK content
RUN mkdir -p /data && mkdir -p /ccache && /usr/bin/ccache -M 100G
VOLUME ["/tmp", "/data", "/ccache"]
WORKDIR /data

COPY ./install-gcc.sh /usr/local/bin/install-gcc.sh
RUN set -ex && \
    /usr/local/bin/install-gcc.sh && \
    dnf autoremove -y && \
    dnf clean all

ENV CC=/usr/local/bin/cc
ENV CXX=/usr/local/bin/c++

COPY ./install-zookeeper.sh /usr/local/bin/install-zookeeper.sh
COPY ./install-hadoop.sh /usr/local/bin/install-hadoop.sh
RUN set -ex &&  \
    /usr/local/bin/install-zookeeper.sh && \
    /usr/local/bin/install-hadoop.sh

COPY ./supervisor /usr/local/supervisor
ENV ZOOKEEPER_HOME /usr/local/zookeeper
ENV HADOOP_HOME /usr/local/hadoop
ENV HDFS_NAMENODE_USER root
ENV HDFS_DATANODE_USER root
ENV HDFS_SECONDARYNAMENODE_USER root
ENV PATH ${PATH}:/usr/local/supervisor/bin:${ZOOKEEPER_HOME}/bin:${HADOOP_HOME}/bin

ENV ASAN_SYMBOLIZER_PATH=/usr/local/bin/llvm-symbolizer
ENV MSAN_SYMBOLIZER_PATH=/usr/local/bin/llvm-symbolizer
ENV TSAN_OPTIONS='halt_on_error=1 history_size=7 ignore_noninstrumented_modules=1'
ENV UBSAN_OPTIONS='print_stacktrace=1'
ENV ASAN_OPTIONS='symbolize=1 malloc_context_size=10 detect_leaks=1 leak_check_at_exit=1'
ENV MSAN_OPTIONS='symbolize=1 poison_in_dtor=1'

COPY ./install-gosu.sh /usr/local/bin/install-gosu.sh
RUN set -ex && /usr/local/bin/install-gosu.sh

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["/bin/bash"]
