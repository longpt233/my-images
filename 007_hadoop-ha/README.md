## Spark- On YARN 

## Description
- zookeeper HA (high-avaibility)


## How to run 



## Cài kdc

```
docker exec -it datanode1_name  bash 

# 2 lệnh export sau hình như không ăn
export KRB5_CONFIG=/storage/kdc/krb5.conf
export KRB5_KDC_PROFILE=/storage/kdc/kdc.conf

# sau khi cài thì có sẵn thư mục 
root@namenode1_host:/# cat /etc/krb5kdc/kdc.conf 
[kdcdefaults]
    kdc_ports = 750,88

[realms]
    EXAMPLE.COM = {
        database_name = /var/lib/krb5kdc/principal
        admin_keytab = FILE:/etc/krb5kdc/kadm5.keytab
        acl_file = /etc/krb5kdc/kadm5.acl
        key_stash_file = /etc/krb5kdc/stash
        kdc_ports = 750,88
        max_life = 10h 0m 0s
        max_renewable_life = 7d 0h 0m 0s
        master_key_type = des3-hmac-sha1
        #supported_enctypes = aes256-cts:normal aes128-cts:normal
        default_principal_flags = +preauth
    }
root@namenode1_host:/# cat /etc/krb5.conf 
[libdefaults]
        default_realm = ATHENA.MIT.EDU
...


# kdb5_util create -r LONGPT.REAML -s  # chạy cái này đê sửa vào 2 cái config trên
# kdb5_util destroy
# https://web.mit.edu/kerberos/krb5-1.5/krb5-1.5/doc/krb5-admin/Creating-and-Destroying-a-Kerberos-Database.html

krb5_newrealm

nano /etc/krb5kdc/kadm5.acl
# bỏ cmt dòng */admin@SECURE.LAB

service krb5-kdc start 
service krb5-kdc status
service krb5-admin-server start
service krb5-admin-server status

nano /lib/systemd/system/krb5-kdc.service
# thêm /var/log/  để ghi được log ra 
ReadWriteDirectories=-/var/tmp /tmp /var/lib/krb5kdc -/var/run /run
ReadWriteDirectories=-/var/tmp /tmp /var/lib/krb5kdc -/var/run /run /var/log/ 
tail /var/log/krb5kdc.log

```

tạo keytab

```
kadmin.local

addprinc -randkey namenode/cluster-172-25-0-2@LONGPT.REALM
addprinc -randkey datanode/cluster-172-25-0-3@LONGPT.REALM
addprinc -randkey datanode/cluster-172-25-0-4@LONGPT.REALM
```

```
ktadd -kt ./hdfs.keytab namenode/cluster-172-25-0-2@LONGPT.REALM datanode/cluster-172-25-0-3@LONGPT.REALM datanode/cluster-172-25-0-4@LONGPT.REALM
klist -e -k -t hdfs.keytab 
KRB5_TRACE=/dev/stdout kinit  -k -t hdfs.keytab namenode/cluster-172-25-0-2@LONGPT.REALM   

addprinc -randkey HTTP/cluster-172-25-0-2@LONGPT.REALM
addprinc -randkey HTTP/cluster-172-25-0-3@LONGPT.REALM
addprinc -randkey HTTP/cluster-172-25-0-4@LONGPT.REALM
ktadd -kt ./http.keytab HTTP/cluster-172-25-0-2@LONGPT.REALM HTTP/cluster-172-25-0-3@LONGPT.REALM HTTP/cluster-172-25-0-4@LONGPT.REALM


```

nếu k có host 

```
kinit: Cannot contact any KDC for realm 'LONGPT.REALM' while getting initial credentials
root@namenode1_host:/# cat /etc/ 
Display all 116 possibilities? (y or n)
root@namenode1_host:/# cat /etc/krb5
krb5.conf  krb5kdc/   
root@namenode1_host:/# cat /etc/krb5.conf 
[libdefaults]
    default_realm = LONGPT.REALM

[realms]
    LONGPT.REALM = {
        kdc = longpt.kdc 
        admin_server = longpt.kdc
    }

```


# HDFS 

```
hdfs@cluster-172-25-0-2:~$ /usr/local/hadoop/bin/hdfs namenode -format
hdfs@cluster-172-25-0-2:~$ /usr/local/hadoop/bin/hdfs --daemon start namenode
hdfs@cluster-172-25-0-2:~$ tail -n 100 /usr/local/hadoop/logs/hadoop-hdfs-datanode-cluster-172-25-0-2.log 


hdfs@cluster-172-25-0-2:~$ /usr/local/hadoop/bin/hdfs --daemon start namenode

wget https://dlcdn.apache.org//commons/daemon/source/commons-daemon-1.3.4-src.tar.gz
tar -xvzf commons-daemon-1.3.4-src.tar.gz 
cd commons-daemon-1.3.4-src/src/native/unix/
# sh support/buildconf.sh ?
./configure --with-java=/usr/lib/jvm/java-8-openjdk-amd64
make
sudo apt-get install build-essential (neu khogn co make)


```


```
datanode 

root@cluster-172-25-0-4:/# /usr/local/hadoop/sbin/hadoop-daemon.sh start datanode
WARNING: Use of this script to start HDFS daemons is deprecated.
WARNING: Attempting to execute replacement "hdfs --daemon start" instead.

# chay voi jsvc thi cac cai /data/dn nay quyen la hdfs, ps aux
root@cluster-172-25-0-4:/# ll /data/
total 16
drwxr-xr-x 4 hdfs hadoop 4096 Mar  7 13:50 ./
drwxr-xr-x 1 root root   4096 Mar  7 13:50 ../
drwxr-xr-x 3 root root   4096 Mar  7 11:54 commons-daemon-1.3.4-src/
drwx------ 2 hdfs hadoop 4096 Mar  7 13:49 dn/

```