```
curl --noproxy '*'  -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @regis-mongo.json 
HTTP/1.1 201 Created
Date: Mon, 29 Jul 2024 04:13:38 GMT
Location: http://localhost:8083/connectors/inventory-connector
Content-Type: application/json
Content-Length: 387
Server: Jetty(9.4.14.v20181114)

{
  "name": "inventory-connector",
  "config": {
    "connector.class": "io.debezium.connector.mongodb.MongoDbConnector",
    "tasks.max": "1",
    "mongodb.hosts": "rs0/localhost:27017",
    "mongodb.name": "local",
    "mongodb.user": "data_etl",
    "mongodb.password": "123456",
    "database.include.list": "inventory",
    "database.history.kafka.bootstrap.servers": "kafka:9092",
    "name": "inventory-connector"
  },
  "tasks": [],
  "type": "source"
}
```

https://github.com/debezium/debezium-examples/tree/1.x/tutorial#using-mongodb


