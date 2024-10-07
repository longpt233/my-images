#! /bin/bash


echo $'
##
# Kerberos KDC
##
172.25.1.10  hadoop110
172.25.1.12  hadoop
' >> /etc/hosts

# chown root. /opt/nifi/conf/flow.json.gz
# chown root. /opt/nifi/conf/flow.xml.gz

# chmod 775 /opt/nifi/conf/flow.json.gz
# chmod 775  /opt/nifi/conf/flow.xml.gz

cd ${NIFI_HOME} &&  ./bin/nifi.sh start && tail -f ./logs/nifi-app.log | grep -e ERROR 
