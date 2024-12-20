1. URN 
uniform resource name
urn:<Namespace>:<Entity Type>:<ID>

ns = li mặc định
entity: resource: eg dataset, dataPlatform

eg:
urn:li:dataPlatform:kafka
urn:li:corpuser:jdoe

datasetURN:
urn:li:dataset:(urn:li:dataPlatform:kafka,PageViewEvent,PROD)
ID bao gồm 3 phần 
- urn:li:dataPlatform:kafka     -> platform (ở đây là 1 urn khác)
- PageViewEvent     -> name
- PROD     -> fabric

2. concept


- authen: policy, role, access token, view 
- Data Platform: như  kiểu Datasets, Dashboards, Charts (metadata graph) : ví dụ Oracle, Hive, HDFS, ClickHouse, Airflow, PostgreSQL, Presto
- Dataset: 
```
Tables or Views in a database
Streams in a stream-processing
Files or Folders in data lake systems
```
- DataJob: Airflow Task
- Data Flow: Airflow DAG (Pipeline)
- quản lí: Glossary Term (từ điển), Tag(label), Domain(category, group, top-level folder), Owner


3. Metadata model
in metadata graph

- Entity: primary node. ví dụ Dataset
- Aspect: một khía cạnh cụ thể của entity, có thể share giữa các entity, ví dụ Owner
- Relationships: 


4. deploy

Internal

- React App (Frontend)
- Generalized Metadata Service (GMS)
- Metadata Change Eevnt (MCE) Consumer
- Metadata Audit Event (MAE) Consumer

External

- Postgres (lưu các thông tin của service Datahub)
- Kafka (Message Queue để nhận event metadata thay đổi hoặc những audit)
- Elasticsearch (search index)
- Neo4J (graph index)