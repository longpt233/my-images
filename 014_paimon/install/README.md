liệu có chạy được flink cdc trên yarn không cho  tích hợp được nhiều vào yarn

debezium mục postgresql-when-things-go-wrong

https://debezium.io/documentation/reference/stable/connectors/postgresql.html#postgresql-when-things-go-wrong

debezium quyền tối thiểu, với lại dùng với addon pgoutput

https://debezium.io/documentation/reference/stable/connectors/postgresql.html#postgresql-replication-user-privileges


Paimon có thể dùng với trino
https://paimon.apache.org/docs/master/engines/trino/

Paimon có thể dùng dưới dang spark (ghi đọc bthg, tuy nhiên k tự cdc được)
https://paimon.apache.org/docs/1.0/spark/quick-start/

Paimon cdc hỗ trợ 
https://paimon.apache.org/docs/1.0/cdc-ingestion/kafka-cdc/
mysql, postgres, mongo, kafka
-> tốt nhất là dùng kk cho thành 1 mối

Paimon cdc kafka hỗ trợ: 
Canal CDC 	
Debezium CDC 	   -> chọn cái này cho lành
Maxwell CDC 	
OGG CDC 	
JSON 	
aws-dms-json 	

Paimon 