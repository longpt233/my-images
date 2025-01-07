
health check 
curl --silent --fail -X GET http://localhost:8083/connectors

long@hello:~/Downloads/Telegram Desktop$ curl localhost:8083/connectors
[]
long@hello:/data/repo/my-images/014_paimon/docker$ curl -X POST localhost:8083/connectors -H "Content-Type: application/json" -d @./connect/source-postgres.json
{
  "name": "dwh.mydatabase.person",
  "config": {
    "topic.prefix": "dbz",
    "database.hostname": "10.208.164.167",
    "database.port": "5431",
    "database.user": "data_etl",
    "database.password": "data_etl",
    "database.dbname": "my_database",
    "schema.include.list": "public",
    "table.include.list": "public.person",
    "heartbeat.interval.ms": "30000",
    "heartbeat.action.query": "select * from public.person where id = 10001",
    "query.fetch.size": "500",
    "topic.creation.groups": "debezium-etl",
    "topic.creation.debezium-etl.include": "",
    "topic.creation.debezium-etl.exclude": "",
    "topic.creation.default.partitions": "-1",
    "topic.creation.default.replication.factor": "-1",
    "plugin.name": "pgoutput",
    "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
    "tasks.max": "1",
    "skipped.operations": "r",
    "snapshot.mode": "never",
    "slot.name": "debezium_person",
    "publication.autocreate.mode": "filtered",
    "publication.name": "dbz_publication",
    "name": "dwh.mydatabase.person"
  },
  "tasks": [],
  "type": "source"
}

long@hello:/data/repo/my-images/014_paimon/docker$ curl -i -X GET -H "Accept:application/json" localhost:8083/connectors/dwh.mydatabase.person/status
HTTP/1.1 200 OK
Date: Tue, 07 Jan 2025 03:01:36 GMT
Content-Type: application/json
Content-Length: 2991
Server: Jetty(9.4.48.v20220622)

{"name":"dwh.mydatabase.person","connector":{"state":"RUNNING","worker_id":"172.20.0.4:8083"},"tasks":[{"id":0,"state":"FAILED","worker_id":"172.20.0.4:8083","trace":"org.apache.kafka.connect.errors.ConnectException: Unable to create filtered publication dbz_publication for \"public\".\"person\"\n\tat io.debezium.connector.postgresql.connection.PostgresReplicationConnection.createOrUpdatePublicationModeFilterted(PostgresReplicationConnection.java:215)\n\tat io.debezium.connector.postgresql.connection.PostgresReplicationConnection.initPublication(PostgresReplicationConnection.java:173)\n\tat io.debezium.connector.postgresql.connection.PostgresReplicationConnection.createReplicationSlot(PostgresReplicationConnection.java:442)\n\tat io.debezium.connector.postgresql.PostgresConnectorTask.start(PostgresConnectorTask.java:140)\n\tat io.debezium.connector.common.BaseSourceTask.startIfNeededAndPossible(BaseSourceTask.java:244)\n\tat io.debezium.connector.common.BaseSourceTask.poll(BaseSourceTask.java:153)\n\tat org.apache.kafka.connect.runtime.AbstractWorkerSourceTask.poll(AbstractWorkerSourceTask.java:457)\n\tat org.apache.kafka.connect.runtime.AbstractWorkerSourceTask.execute(AbstractWorkerSourceTask.java:351)\n\tat org.apache.kafka.connect.runtime.WorkerTask.doRun(WorkerTask.java:202)\n\tat org.apache.kafka.connect.runtime.WorkerTask.run(WorkerTask.java:257)\n\tat org.apache.kafka.connect.runtime.AbstractWorkerSourceTask.run(AbstractWorkerSourceTask.java:75)\n\tat org.apache.kafka.connect.runtime.isolation.Plugins.lambda$withClassLoader$1(Plugins.java:177)\n\tat java.base/java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:515)\n\tat java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)\n\tat java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)\n\tat java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)\n\tat java.base/java.lang.Thread.run(Thread.java:829)\nCaused by: org.postgresql.util.PSQLException: ERROR: permission denied for database my_database\n\tat org.postgresql.core.v3.QueryExecutorImpl.receiveErrorResponse(QueryExecutorImpl.java:2676)\n\tat org.postgresql.core.v3.QueryExecutorImpl.processResults(QueryExecutorImpl.java:2366)\n\tat org.postgresql.core.v3.QueryExecutorImpl.execute(QueryExecutorImpl.java:356)\n\tat org.postgresql.jdbc.PgStatement.executeInternal(PgStatement.java:496)\n\tat org.postgresql.jdbc.PgStatement.execute(PgStatement.java:413)\n\tat org.postgresql.jdbc.PgStatement.executeWithFlags(PgStatement.java:333)\n\tat org.postgresql.jdbc.PgStatement.executeCachedSql(PgStatement.java:319)\n\tat org.postgresql.jdbc.PgStatement.executeWithFlags(PgStatement.java:295)\n\tat org.postgresql.jdbc.PgStatement.execute(PgStatement.java:290)\n\tat io.debezium.connector.postgresql.connection.PostgresReplicationConnection.createOrUpdatePublicationModeFilterted(PostgresReplicationConnection.java:21


-> sai pub name -> day lai

long@hello:/data/repo/my-images/014_paimon/docker$ curl -i -X DELETE localhost:8083/connectors/dwh.mydatabase.person
HTTP/1.1 204 No Content
Date: Tue, 07 Jan 2025 03:04:01 GMT
Server: Jetty(9.4.48.v20220622)


PUT: curl -i -X PUT -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors/inventory-connector/config -d '{ "connector.class": "io.debezium.connector.mysql.MySqlConnector", "tasks.max": "1", "database.hostname": "mysql", "database.port": "3306", "database.user": "debezium", "database.password": "dbz", "database.server.id": "184054", "database.server.name": "dbserver1", "database.include.list": "inventory", "database.history.kafka.bootstrap.servers": "kafka:9092", "database.history.kafka.topic": "dbhistory.inventory" }'


API thông tin

long@hello:/data/repo/my-images/014_paimon/docker$ curl -i -X GET -H "Accept:application/json" localhost:8083/connectors/dwh.mydatabase.person/status
HTTP/1.1 200 OK
Date: Tue, 07 Jan 2025 03:17:02 GMT
Content-Type: application/json
Content-Length: 177
Server: Jetty(9.4.48.v20220622)

{"name":"dwh.mydatabase.person","connector":{"state":"RUNNING","worker_id":"172.20.0.4:8083"},"tasks":[{"id":0,"state":"RUNNING","worker_id":"172.20.0.4:8083"}],"type":"source"}

long@hello:/data/repo/my-images/014_pacurl -i -X GET -H "Accept:application/json" localhost:8083/connectors/dwh.mydatabase.person/config
HTTP/1.1 200 OK
Date: Tue, 07 Jan 2025 03:20:13 GMT
Content-Type: application/json
Content-Length: 872
Server: Jetty(9.4.48.v20220622)

{"connector.class":"io.debezium.connector.postgresql.PostgresConnector","topic.creation.default.partitions":"-1","slot.name":"debezium_person","query.fetch.size":"500","tasks.max":"1","publication.name":"dbz_pub","schema.include.list":"public","topic.creation.debezium-etl.include":"","topic.prefix":"dbz","heartbeat.action.query":"select * from public.person where id = 10001","topic.creation.default.replication.factor":"-1","publication.autocreate.mode":"filtered","database.user":"data_etl","database.dbname":"my_database","heartbeat.interval.ms":"30000","database.port":"5431","plugin.name":"pgoutput","topic.creation.groups":"debezium-etl","topic.creation.debezium-etl.exclude":"","database.hostname":"10.208.164.167","database.password":"data_etl","name":"dwh.mydatabase.person","table.include.list":"public.person","skipped.operations":"r","snapshot.mode":"never"}

long@hello:/data/repo/my-images/014_paimon/docker$ curl -i -X GET -H "Accept:application/json" localhost:8083/connectors/dwh.mydatabase.person/restart
HTTP/1.1 405 Method Not Allowed
Date: Tue, 07 Jan 2025 03:21:38 GMT
Content-Length: 58
Server: Jetty(9.4.48.v20220622)

{"error_code":405,"message":"HTTP 405 Method Not Allowed"}

long@hello:/data/repo/my-images/014_paimon/docker$ curl -i -X GET -H "Accept:application/json" localhost:8083/connectors/dwh.mydatabase.person/task
HTTP/1.1 404 Not Found
Date: Tue, 07 Jan 2025 03:21:23 GMT
Content-Length: 49
Server: Jetty(9.4.48.v20220622)

{"error_code":404,"message":"HTTP 404 Not Found"}l


