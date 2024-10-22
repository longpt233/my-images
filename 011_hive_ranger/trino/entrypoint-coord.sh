#!/bin/bash


mkdir -p /var/trino/data

echo ' 
coordinator=true 
node-scheduler.include-coordinator=false
http-server.http.port=8080
discovery.uri=http://172.25.1.14:8080
internal-communication.shared-secret=internal-shared-secret
http-server.authentication.type=PASSWORD
http-server.process-forwarded=true
http-server.authentication.allow-insecure-over-http=true
' > /usr/local/trino/etc/config.properties


echo ' 
node.environment=production
node.id=c1c2c357-a192-4b69-8a84-e86509c7d0d6
node.data-dir=/var/trino/data
'  > /usr/local/trino/etc/node.properties


export JAVA_HOME=/usr/local/java && export TRINO_HOME=/usr/local/trino

java -version

cd /opt/trino-ranger-plugin && ./enable-trino-plugin.sh  

/usr/local/trino/bin/launcher start
# neu loi thi xem file nay truoc ?
# tail -n 1000  /var/trino/data/var/log/launcher.log

cat /opt/trino-ranger-plugin/install.properties

 

sleep 3
tail -f 1000  /var/trino/data/var/log/server.log | grep ERROR

tail -f /dev/null

exec $@
