#!/bin/bash


mkdir -p /var/trino/data


echo ' 
coordinator=false
http-server.http.port=8080
discovery.uri=http://172.25.1.14:8080
internal-communication.shared-secret=internal-shared-secret
'  > /usr/local/trino/etc/config.properties


echo ' 
node.environment=production
node.id=da1ee33a-3c84-46e7-9921-b4492e9ebf24
node.data-dir=/var/trino/data
'  > /usr/local/trino/etc/node.properties

export JAVA_HOME=/usr/local/java && export TRINO_HOME=/usr/local/trino
/usr/local/trino/bin/launcher start

sleep 3
tail -f 1000  /var/trino/data/var/log/server.log | grep ERROR


#tail -f /dev/null

exec $@
