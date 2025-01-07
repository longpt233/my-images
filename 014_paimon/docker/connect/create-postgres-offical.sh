# đăng nhập


root@postgres:/# su - postgres
postgres@postgres:~$ psql 
psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  role "postgres" does not exist
postgres@postgres:~$ psql -U admin 
psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  database "admin" does not exist
postgres@postgres:~$ psql -U admin -d postgres 
psql (15.10 (Debian 15.10-1.pgdg120+1))
Type "help" for help.

postgres=# \dRp
                              List of publications
 Name | Owner | All tables | Inserts | Updates | Deletes | Truncates | Via root 
------+-------+------------+---------+---------+---------+-----------+----------
(0 rows)

postgres=# 



# tạo nhé


root@postgres:/# su - postgres
postgres@postgres:~$ psql -U admin -d postgres 
postgres=# CREATE ROLE data_etl
WITH
LOGIN
REPLICATION
CONNECTION LIMIT -1
PASSWORD 'data_etl'; 
\c my_database
GRANT USAGE ON SCHEMA public TO data_etl;


my_database=# \dRp+
Did not find any publications.
my_database=# CREATE PUBLICATION dbz_pub;
CREATE PUBLICATION
my_database=# ALTER PUBLICATION dbz_pub ADD TABLE public.person;
ALTER PUBLICATION
my_database=# ALTER PUBLICATION dbz_pub OWNER TO data_etl;
ALTER PUBLICATION
my_database=# \dRp+
                            Publication dbz_pub
  Owner   | All tables | Inserts | Updates | Deletes | Truncates | Via root 
----------+------------+---------+---------+---------+-----------+----------
 data_etl | f          | t       | t       | t       | t         | f
Tables:
    "public.person"

my_database=# 


my_database=> SELECT * FROM pg_publication_tables;
 pubname | schemaname | tablename |   attnames    | rowfilter 
---------+------------+-----------+---------------+-----------
 dbz_pub | public     | person    | {id,name,age} | 
(1 row)


-> ERROR: permission denied for database my_database   -> lỗi trên UI viết vớ vẩn, tốt nhất vẫn là status curl

my_database=> SELECT * FROM pg_replication_slots;
slot_name        |  plugin  | slot_type | datoid |  database   | temporary | active | active_pid | xmin | catalog_xmin | restart_lsn | confirmed_flush_lsn | wal_status | safe_wal_size | two_phase 
-----------------+----------+-----------+--------+-------------+-----------+--------+------------+------+--------------+-------------+---------------------+------------+---------------+-----------
 debezium_person | pgoutput | logical   |  17271 | my_database | f         | t      |       6606 |      |         1013 | 0/1FEEC48   | 0/1FEEC80           | reserved   |               | f
(1 row)
my_database=> SELECT * FROM pg_stat_replication_slots;
    slot_name    | spill_txns | spill_count | spill_bytes | stream_txns | stream_count | stream_bytes | total_txns | total_bytes | stats_reset 
-----------------+------------+-------------+-------------+-------------+--------------+--------------+------------+-------------+-------------
 debezium_person |          0 |           0 |           0 |           0 |            0 |            0 |          0 |           0 | 
(1 row)



debezium_person -> laf slot name trong cau hinh dbz

khi thêm dữ liệu -> tăng byte lên nè
my_database=> INSERT INTO person (id, name, age) VALUES (11,'John Doe', 30);
INSERT 0 1
my_database=> SELECT * FROM pg_stat_replication_slots;
    slot_name    | spill_txns | spill_count | spill_bytes | stream_txns | stream_count | stream_bytes | total_txns | total_bytes | stats_reset 
-----------------+------------+-------------+-------------+-------------+--------------+--------------+------------+-------------+-------------
 debezium_person |          0 |           0 |           0 |           0 |            0 |            0 |          1 |         148 | 
(1 row)

