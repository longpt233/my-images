CREATE DATABASE hive;
CREATE USER hive WITH PASSWORD 'hive';
GRANT ALL PRIVILEGES ON DATABASE hive TO hive;
-- PostgreSQL 15 requires additional privileges:
GRANT ALL ON SCHEMA public TO hive;
ALTER DATABASE hive OWNER TO hive;

-- chu y khi import db bang user hive thif can chuyen lai quyen cho db neu k import lai se bi loi 


CREATE DATABASE trino_resource_groups;
CREATE USER trino_resource_groups WITH PASSWORD 'trino_resource_groups';
GRANT ALL PRIVILEGES ON DATABASE trino_resource_groups TO trino_resource_groups;
-- PostgreSQL 15 requires additional privileges:
GRANT ALL ON SCHEMA public TO trino_resource_groups;
ALTER DATABASE trino_resource_groups OWNER TO trino_resource_groups;
