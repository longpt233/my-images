#!/bin/bash

# the default node number is 3
N=${1:-3}


# start hadoop master container
sudo docker rm -f hbse-master &> /dev/null
echo "start hbase-master container..."
sudo docker run -itd \
                --net=hadoop \
                -p 16010:16010 \
                --name hbase-master \
                --hostname hbase-master \
                dinhphu/hbase:1.0 &> /dev/null


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hbase-slave$i &> /dev/null
	echo "start hbase-slave$i container..."
	sudo docker run -itd \
	                --net=hadoop \
	                --name hbase-slave$i \
	                --hostname hbase-slave$i \
	                dinhphu/hbase:1.0 &> /dev/null
	i=$(( $i + 1 ))
done 

# get into hadoop master container
sudo docker exec -it hbase-master bash
