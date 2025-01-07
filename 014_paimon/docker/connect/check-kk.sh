1. liệt kê topic

[appuser@kafka opt]$ /usr/bin/kafka-topics --list --bootstrap-server localhost:9092
__consumer_offsets
__debezium-heartbeat.dbz
connect_configs
connect_offsets
connect_statuses
dbz.public.person

2. mô tả topic

[appuser@kafka opt]$ /usr/bin/kafka-topics --describe  --bootstrap-server localhost:9092  --topic dbz.public.person
Topic: dbz.public.person	TopicId: 0cbKinotRM2QiICnZyuVIA	PartitionCount: 1	ReplicationFactor: 1	Configs: 
	Topic: dbz.public.person	Partition: 0	Leader: 1	Replicas: 1	Isr: 1

[appuser@kafka opt]$ /usr/bin/kafka-topics --describe  --bootstrap-server localhost:9092  --topic connect_configs
Topic: connect_configs	TopicId: yt02CV1KS_e-BivI-QbGCw	PartitionCount: 1	ReplicationFactor: 1	Configs: cleanup.policy=compact
	Topic: connect_configs	Partition: 0	Leader: 1	Replicas: 1	Isr: 1

[appuser@kafka opt]$ /usr/bin/kafka-topics --describe  --bootstrap-server localhost:9092  --topic __debezium-heartbeat.dbz
Topic: __debezium-heartbeat.dbz	TopicId: 7zFVCOCoR8GR8m385xPzYQ	PartitionCount: 1	ReplicationFactor: 1	Configs: 
	Topic: __debezium-heartbeat.dbz	Partition: 0	Leader: 1	Replicas: 1	Isr: 1

[appuser@kafka opt]$ /usr/bin/kafka-topics --describe  --bootstrap-server localhost:9092  --topic __consumer_offsets
Topic: __consumer_offsets	TopicId: qgH-Hri1TNuXwcNOZjnndQ	PartitionCount: 50	ReplicationFactor: 1	Configs: compression.type=producer,cleanup.policy=compact,segment.bytes=104857600
	Topic: __consumer_offsets	Partition: 0	Leader: 1	Replicas: 1	Isr: 1
	Topic: __consumer_offsets	Partition: 1	Leader: 1	Replicas: 1	Isr: 1
	Topic: __consumer_offsets	Partition: 2	Leader: 1	Replicas: 1	Isr: 1
	Topic: __consumer_offsets	Partition: 3	Leader: 1	Replicas: 1	Isr: 1
	Topic: __consumer_offsets	Partition: 4	Leader: 1	Replicas: 1	Isr: 1
	Topic: __consumer_offsets	Partition: 5	Leader: 1	Replicas: 1	Isr: 1
	Topic: __consumer_offsets	Partition: 6	Leader: 1	Replicas: 1	Isr: 1
	Topic: __consumer_offsets	Partition: 7	Leader: 1	Replicas: 1	Isr: 1
.... mặc định 50 parttition


3. liệt kê group

[appuser@kafka opt]$ /usr/bin/kafka-consumer-groups --bootstrap-server  localhost:9092   --list
[appuser@kafka opt]$ /usr/bin/kafka-console-consumer --bootstrap-server  localhost:9092 --topic dbz.public.person --from-beginning --group dbz.public.person.group1

{"schema":{"type":"struct","fields":[{"type":"struct","fields":[{"type":"int32","optional":false,"field":"id"},{"type":"string","optional":true,"field":"name"},{"type":"int32","optional":true,"field":"age"}],"optional":true,"name":"dbz.public.person.Value","field":"before"},{"type":"struct","fields":[{"type":"int32","optional":false,"field":"id"},{"type":"string","optional":true,"field":"name"},{"type":"int32","optional":true,"field":"age"}],"optional":true,"name":"dbz.public.person.Value","field":"after"},{"type":"struct","fields":[{"type":"string","optional":false,"field":"version"},{"type":"string","optional":false,"field":"connector"},{"type":"string","optional":false,"field":"name"},{"type":"int64","optional":false,"field":"ts_ms"},{"type":"string","optional":true,"name":"io.debezium.data.Enum","version":1,"parameters":{"allowed":"true,last,false,incremental"},"default":"false","field":"snapshot"},{"type":"string","optional":false,"field":"db"},{"type":"string","optional":true,"field":"sequence"},{"type":"string","optional":false,"field":"schema"},{"type":"string","optional":false,"field":"table"},{"type":"int64","optional":true,"field":"txId"},{"type":"int64","optional":true,"field":"lsn"},{"type":"int64","optional":true,"field":"xmin"}],"optional":false,"name":"io.debezium.connector.postgresql.Source","field":"source"},{"type":"string","optional":false,"field":"op"},{"type":"int64","optional":true,"field":"ts_ms"},{"type":"struct","fields":[{"type":"string","optional":false,"field":"id"},{"type":"int64","optional":false,"field":"total_order"},{"type":"int64","optional":false,"field":"data_collection_order"}],"optional":true,"name":"event.block","version":1,"field":"transaction"}],"optional":false,"name":"dbz.public.person.Envelope","version":1},"payload":{"before":null,"after":{"id":11,"name":"John Doe","age":30},"source":{"version":"2.2.1.Final","connector":"postgresql","name":"dbz","ts_ms":1736219588925,"snapshot":"false","db":"my_database","sequence":"[null,\"33484240\"]","schema":"public","table":"person","txId":1014,"lsn":33484240,"xmin":null},"op":"c","ts_ms":1736219588954,"transaction":null}}
^CProcessed a total of 1 messages
[appuser@kafka opt]$ /usr/bin/kafka-consumer-groups --bootstrap-server  localhost:9092   --list
dbz.public.person.group1
[appuser@kafka opt]$ /usr/bin/kafka-consumer-groups --describe 'dbz.public.person' --bootstrap-server localhost:9092 --all-groups

Consumer group 'dbz.public.person.group1' has no active members.

GROUP                    TOPIC             PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID     HOST            CLIENT-ID
dbz.public.person.group1 dbz.public.person 0          1               1               0               -               -               -


4. đọc mess 

[appuser@kafka opt]$ /usr/bin/kafka-console-consumer --bootstrap-server  localhost:9092 --topic dbz.public.person --from-beginning --group connect_configs
{"schema":{"type":"struct","fields":[{"type":"struct","fields":[{"type":"int32","optional":false,"field":"id"},{"type":"string","optional":true,"field":"name"},{"type":"int32","optional":true,"field":"age"}],"optional":true,"name":"dbz.public.person.Value","field":"before"},{"type":"struct","fields":[{"type":"int32","optional":false,"field":"id"},{"type":"string","optional":true,"field":"name"},{"type":"int32","optional":true,"field":"age"}],"optional":true,"name":"dbz.public.person.Value","field":"after"},{"type":"struct","fields":[{"type":"string","optional":false,"field":"version"},{"type":"string","optional":false,"field":"connector"},{"type":"string","optional":false,"field":"name"},{"type":"int64","optional":false,"field":"ts_ms"},{"type":"string","optional":true,"name":"io.debezium.data.Enum","version":1,"parameters":{"allowed":"true,last,false,incremental"},"default":"false","field":"snapshot"},{"type":"string","optional":false,"field":"db"},{"type":"string","optional":true,"field":"sequence"},{"type":"string","optional":false,"field":"schema"},{"type":"string","optional":false,"field":"table"},{"type":"int64","optional":true,"field":"txId"},{"type":"int64","optional":true,"field":"lsn"},{"type":"int64","optional":true,"field":"xmin"}],"optional":false,"name":"io.debezium.connector.postgresql.Source","field":"source"},{"type":"string","optional":false,"field":"op"},{"type":"int64","optional":true,"field":"ts_ms"},{"type":"struct","fields":[{"type":"string","optional":false,"field":"id"},{"type":"int64","optional":false,"field":"total_order"},{"type":"int64","optional":false,"field":"data_collection_order"}],"optional":true,"name":"event.block","version":1,"field":"transaction"}],"optional":false,"name":"dbz.public.person.Envelope","version":1},"payload":{"before":null,"after":{"id":11,"name":"John Doe","age":30},"source":{"version":"2.2.1.Final","connector":"postgresql","name":"dbz","ts_ms":1736219588925,"snapshot":"false","db":"my_database","sequence":"[null,\"33484240\"]","schema":"public","table":"person","txId":1014,"lsn":33484240,"xmin":null},"op":"c","ts_ms":1736219588954,"transaction":null}}



