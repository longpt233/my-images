#! /bin/bash

# Add Kerberos KDC hostname
echo $'
##
# Kerberos KDC
##
172.25.1.10  hadoop110
' >> /etc/hosts

# mkdir /etc/sudoers.d . nếu k có file này tức là chưa cài sudo package
echo longpt ALL=NOPASSWD:ALL | tee -a  /etc/sudoers.d/longpt


su - longpt -c $'\
          whoami && \
          mkdir .ssh && \
          echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDG0SGKhiZPlZSClr4Q/s461cgWIZ1RLg5PbqL+7pvLMaoNzzbiSUC6wENklyBX8VVNlJddHG/PgvsML7NDfUv23scHOf2rCoDTxIf6jywh0n0qVdoPN2Wge3zbElutKSizyBwwGbX89+GDS3vcnIE3uUpa3DXwixr+w9hJFh4lxcQMn4GtXH9+WzKAjLyLXFLtD+bwYRXdj7PC+bD0ibvjnHJNyFbu4HckIZr/+YrIz++bIjOB8KItdGD/euJlAfKgv+7fRW8ejnxLV35QzvRRcR4awsRZzzRpg+aWTSj/qaEvty1BZYkiCFHEKyHqHTNWC9tdhyagX8ekDOUQv9IHWr8mbUpGXAvVI49UiEiyAwTPN82hwKrymo1LtDpFGPeMy/OfwUqAzIaxyLhefQJjUy8g946aZwnVcWDaULI0Z9GOthWeGWtq70q34Q7TXQjPmrtmLd40c5Pqzp/kIUizMBNamdviEwa3G8cIy3Pen9Yi7hVledEisuOruPD8qWKjXzOOEaCdXJ3UiQuEtnZueWTUaUO3uq9kpZkF6R80S4T3G7q6DttbX8jDQ/DcWfUHQEtrX6A1+CuJpQwsKd+x9FK9FFLQDeKw94IhepVKrS1gn8GXsmdz8FL0Guj4ftki+3VJP9HfezWu5mFw/oFjQCt/xo2VvKyJ7DPPVeDEPw== long@hello" > .ssh/authorized_keys && \
          chmod 700 .ssh && \
          chmod 600 .ssh/authorized_keys && \
          file_path=".ssh/authorized_keys" && \
          echo "cat file $file_path after make change" && \
          cat $file_path '

# su - hdfs -c $'ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""'

service ssh start

krb5kdc

/opt/hadoop/bin/hdfs namenode -format

klist -e -k -t /hdfs.keytab

sleep 10
/opt/hadoop/bin/hdfs --daemon start namenode
sleep 20
chown -R hdfs. /storage
/opt/hadoop/bin/hdfs --daemon start datanode
sleep 10
echo "secure" && jps

kinit -kt /hdfs.keytab namenode/hadoop110@HADOOP.REALM
/opt/hadoop/bin/hdfs dfs -ls /


tail -f /dev/null 
