1. sửa mấy file config dưới local 

- hadoop-env : sửa trỏ java home . không để = JAVA_HOME vì nó có thể k nhận conf 
- hdfs-site: để đường dẫn tuyệt đối

2. chuyển lên server 

```
~/gw-send ./auto-install longpt@10.5.0.242:tmp
rsync -avPz -e "ssh -p 2395" ./auto-install longpt@10.5.92.76:/home/longpt
```

3. check các điều kiện

```
có jdk : 
cd /usr/lib/jvm/java-8-openjdk-amd64/jre
```