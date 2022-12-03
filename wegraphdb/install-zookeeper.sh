#!/bin/bash
set -ex

# zookeeper
curl -o /tmp/apache-zookeeper-3.8.0-bin.tar.gz  --insecure --retry 12 --retry-max-time 0 -C - -SL http://mirrors.tencent.com/apache/zookeeper/zookeeper-3.8.0/apache-zookeeper-3.8.0-bin.tar.gz
tar -zxvf /tmp/apache-zookeeper-3.8.0-bin.tar.gz -C /usr/local/
ln -s /usr/local/apache-zookeeper-3.8.0-bin /usr/local/zookeeper
cat > /usr/local/zookeeper/conf/zoo.cfg << EOF
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/tmp/zookeeper
clientPort=2181
admin.enableServer=false
EOF
rm -rf /tmp/apache-zookeeper-3.8.0-bin.tar.gz
