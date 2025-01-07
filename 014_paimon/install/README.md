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

Paimon dùng LMS tree để tổ chức dữ liệu


Streaming lakehouse: các công nghệ: 
- Spark and Apache Kudu
- Apache Flink and Apache Hudi
- Apache Flink and Apache Paimon

https://www.alibabacloud.com/blog/apache-paimon-streaming-lakehouse-is-coming_601357

Compare paimon - hudi: Paimon provides better read and write performance than Hudi and requires less memory

https://www.alibabacloud.com/blog/building-a-streaming-lakehouse-performance-comparison-between-paimon-and-hudi_601013

