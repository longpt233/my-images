# NOTE: This is the simplest way of achieving a replicaset in mongodb with Docker.
# However if you would like a more automated approach, please see the setup.sh file and the docker-compose file which includes this startup script.

# run this after setting up the docker-compose This will instantiate the replica set.
# The id and hostname's can be tailored to your liking, however they MUST match the docker-compose file above.

chmod +x /scripts/setup.sh

docker-compose up -d
docker exec -it localmongo1 mongo

```
rs.initiate(
  {
    _id : 'rs0',
    members: [
      { _id : 0, host : "mongo1:27017" },
      { _id : 1, host : "mongo2:27017" },
      { _id : 2, host : "mongo3:27017", arbiterOnly: true }
    ]
  }
)
```
```
{
        "info" : "try querying local.system.replset to see current configuration",
        "ok" : 0,
        "errmsg" : "already initialized",
        "code" : 23,
        "codeName" : "AlreadyInitialized",
        "operationTime" : Timestamp(1722223742, 1),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1722223742, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}
```

exit


rs.initiate(
  {
    _id : 'rs0',
    members: [
      { _id : 0, host : "mongo1:27017" },
    ]
  }
)

