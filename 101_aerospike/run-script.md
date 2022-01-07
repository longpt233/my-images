### how to run 
``` bash 
docker pull aerospike:5.1.0.5
docker run -d --name aerospike -p 3000-3002:3000-3002 aerospike:5.1.0.5
```

### show bash 

``` bash 
docker exec -it <container_id> bash
```

### check and show Aerospike Query Client (aql)

``` bash 
asd --version
aql 
```

asd - aerospike daemon ? 

### aql 

``` https://docs.aerospike.com/docs/tools/aql/ ```

``` sql
show namespaces
insert into test.foo (PK, foo) values ('123','my string')
select * from test.foo
```