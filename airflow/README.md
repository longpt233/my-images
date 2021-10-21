### origin 

```
https://github.com/puckel/docker-airflow
```

### docker hub 
``` bash
docker build -t longpt233/airflow:v1 .
docker login 
docker push longpt233/airflow:v1

```
### how to use 

- celery excuter : cluster mode 
``` bash 
docker-compose -f docker-compose-CeleryExecutor.yml scale worker=5
```

- local mode 

``` bash 
docker-compose -f docker-compose-LocalExecutor.yml up -d 
```


### err 
```
80: starting container process caused: exec: "/entrypoint.sh": permission denied: unknown
```

- grant before build image 

```
chmod +x script/entrypoint.sh
```