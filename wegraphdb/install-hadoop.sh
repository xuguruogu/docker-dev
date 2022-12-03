#!/bin/bash
set -ex

# hdfs
curl -o /tmp/hadoop-3.3.4.tar.gz  --insecure --retry 12 --retry-max-time 0 -C - -SL http://mirrors.tencent.com/apache/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz
tar -zxvf /tmp/hadoop-3.3.4.tar.gz -C /usr/local/
ln -s /usr/local/hadoop-3.3.4 /usr/local/hadoop
chown -R root:root /usr/local/hadoop-3.3.4/

JAVA_HOME_SED=$(echo "${JAVA_HOME}" | sed -e 's/\//\\\//g')
sed -i "s/^# export JAVA_HOME.*/export JAVA_HOME=${JAVA_HOME_SED}/g" /usr/local/hadoop/etc/hadoop/hadoop-env.sh

ssh-keygen -t rsa -f "$HOME/.ssh/id_rsa" -N ""
cat "$HOME/.ssh/id_rsa.pub" >> "$HOME/.ssh/authorized_keys"
chmod 600 "$HOME/.ssh/authorized_keys"

cat > /usr/local/hadoop/etc/hadoop/core-site.xml << EOF
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>
EOF

cat > /usr/local/hadoop/etc/hadoop/hdfs-site.xml << EOF
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
EOF

/usr/local/hadoop/bin/hdfs namenode -format

rm /tmp/hadoop-3.3.4.tar.gz
