# run 

- attach vô master 

```
docker exec -it hadoop-master bash    
hadoop namenode -format
start-all.sh  

root@36edab921c07:/# spark-shell --master yarn  --num-executors 3 --executor-memory 1G --executor-cores 3
```
- nhớ format trc khi run không thì có thể k chạy datanode


- [node label doc](https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.1.0/data-operating-system/content/configuring_node_labels.html)
