## Hadoop single node 

## Description
- chi co 1 node hadoop (start 2 daemon namenode + datanode) doc va ghi


## How to run 
```bash
docker-compose build
docker-compose up
```

- attach 
```bash
docker exec -it hadoop-name bash
```

- check 
```bash
jps
```

# How to use 
- co gi tu cop file vao ma test nha 
- view o http://localhost:9870


## Structure 

```
001_hadoop
│   README.md
│
└───config
│   │   
│   └───
|
└───Dockerfile
```


## author 
- https://github.com/kiwenlau/hadoop-cluster-docker