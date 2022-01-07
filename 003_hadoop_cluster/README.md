## Hadoop cluster mode

## Description
- 3 node, bat yarn  


## How to run 
```bash
docker-compose build
docker-compose up 
```

- attach vao xong bat cac dich vu
```bash
docker exec -it hadoop-master-name bash
start-all.sh

```

## Structure 

```
001_hadoop
│   README.md
│
└───conf
│   │   
│   └───
|
└───Dockerfile
```


## author 
- https://github.com/kiwenlau/hadoop-cluster-docker