CREATE DATABASE hive;
CREATE USER hive WITH PASSWORD 'hive';
GRANT ALL PRIVILEGES ON DATABASE hive TO hive;
-- PostgreSQL 15 requires additional privileges:
GRANT ALL ON SCHEMA public TO hive;
ALTER DATABASE hive OWNER TO hive;

# chu y khi import db bang user hive thif can chuyen lai quyen cho db neu k import lai se bi loi 
