# SETUP HADOOP-HBASE-CLUSTR BY DOCKER

## 1. Create network
```
sudo docker network create --driver=bridge hadoop
```

## 2. Start Hadoopp-cluster

1 namenode và 2 datanode

**Build image**
```
cd hadoop
sudo ./start-container.sh
```
Nó sẽ khởi tạo 1 container 'hadooop-master' và 2 container 'hadoop-slave'

và đi vào thư mục /root của hadoop-master container

**Start cluster**
```
./start-hadoop.sh
```

## 3. Start Zookeeper-cluster
```
cd zookeeper
docker compose up
```

## 4. Start Hbase-cluster

**Build image**
```
cd hbase
sudo ./start-container.sh
```

Nó sẽ khởi tạo 1 container 'hbase-master' và 2 container 'hbase-slave'

và đi vào thư mục /root của hadoop-master container

**Start cluster**
```
./start-hbase.sh
```

**Note**: khi chạy hbase cluster có thể sẽ báo lỗi  `zoo1: ssh: connect to host zoo1 port 22: Connection refused`, cứ kệ nó, k sao cả

## 5. Tùy chỉnh
Nếu múôn tùy chỉnh số lượng nút thì có thể khởi chạy vs số lượng container khác nhau

**Note**: 
- ở đây đang chạy 1 master và 2 slave, nên nếu muốn tăng giảm số lượng slave thì phải vào trong Hadoop config lại số  ```workers``` và Hbase ```regionservers```
- các container phải khởi chạy trên cùng 1 mạng
