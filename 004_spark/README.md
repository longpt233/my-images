## Spark- standalone

## Description
- spark base to test submit job 

## How to run 
```bash
docker-compose build
docker-compose up
```

- attach 
```bash
docker exec -it spark-master-name bash
spark-shell
```

## Structure 

```
001_hadoop
│   README.md
└───Dockerfile
└───docker-compose.yml
```