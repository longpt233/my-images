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


# tao bang 

CREATE DATABASE my_database;
\c my_database
select * from person;
truncate table person;
drop  table person;
CREATE TABLE person (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT
);

select * from public.person where id = 10001;


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

my_database=# CREATE ROLE replication_group;
CREATE ROLE
my_database=# \d
        List of relations
 Schema |  Name  | Type  | Owner 
--------+--------+-------+-------
 public | person | table | admin
(1 row)

my_database=# GRANT replication_group TO admin;
GRANT ROLE
my_database=# GRANT replication_group TO data_etl;
GRANT ROLE
my_database=# ALTER TABLE public.person OWNER TO replication_group;
ALTER TABLE
my_database=# \d+
                                         List of relations
 Schema |  Name  | Type  |       Owner       | Persistence | Access method |  Size   | Description 
--------+--------+-------+-------------------+-------------+---------------+---------+-------------
 public | person | table | replication_group | permanent   | heap          | 0 bytes | 
(1 row)

# my_database=# GRANT CONNECT ON DATABASE my_database TO data_etl;


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

# LSN (Long Sequence Number) -> tương đương với offset của kafka trong việc check xem WAL đã tới đâu rồi
# two hexadecimal numbers separated by a slash, e.g. 16/B374D848

# debezium dùng replication slot and publications để read từ WAL

# + publications là cơ chế chuyển stream change tới một thằng consumer (ở đây là debezium). có thể chỉ định (LỰA CHỌN được) publications trên bảng nào, cột nào, các action nào (DML (Data Manipulation Language) - khác với DDL (Data Definition Language))
# nếu cho debezium quyền này thì mình có thể cấu hình lựa chọn bên phía debezium

# + Replication slots


# WAL LEVEL
# wal_level cannot be changed without restarting the PostgreSQL server
# wal_level determines how much information is written to the WAL
# minimal: chỉ dữ lại log đủ để khôi phục khi crash hoặc immediate shutdown. không đủ để recover point-in-time
# replica (default) : WAL archiving and replication. đi kèm max_wal_senders >0 . trước 9.6 thì là tương đương archive hoặc hot_standby.
# logical: support thêm logical decoding (logical change). increase the WAL volume
my_database=> select * from pg_settings where name ='wal_level';
   name    | setting | unit |          category          |                    short_desc                     | extra_desc |  context   | vartype |    source    | min_val | max_val |         enumvals          | boot_val | reset_val | sourcefile | sourceline | pending_restart 
-----------+---------+------+----------------------------+---------------------------------------------------+------------+------------+---------+--------------+---------+---------+---------------------------+----------+-----------+------------+------------+-----------------
 wal_level | logical |      | Write-Ahead Log / Settings | Sets the level of information written to the WAL. |            | postmaster | enum    | command line |         |         | {minimal,replica,logical} | replica  | logical   |            |            | f
(1 row)



khi thêm dữ liệu -> tăng byte lên nè
my_database=> INSERT INTO person (id, name, age) VALUES (11,'John Doe', 30);
INSERT 0 1
my_database=> SELECT * FROM pg_stat_replication_slots;
    slot_name    | spill_txns | spill_count | spill_bytes | stream_txns | stream_count | stream_bytes | total_txns | total_bytes | stats_reset 
-----------------+------------+-------------+-------------+-------------+--------------+--------------+------------+-------------+-------------
 debezium_person |          0 |           0 |           0 |           0 |            0 |            0 |          1 |         148 | 
(1 row)


#  
my_database=> SELECT * FROM pg_stat_replication;
 pid  | usesysid | usename  |  application_name  | client_addr | client_hostname | client_port |         backend_start         | backend_xmin | state | sent_lsn | write_lsn | flush_lsn | replay_lsn | write_lag | flush_lag | replay_lag | sync_priority | sync_state | reply_time 
------+----------+----------+--------------------+-------------+-----------------+-------------+-------------------------------+--------------+-------+----------+-----------+-----------+------------+-----------+-----------+------------+---------------+------------+------------
 6606 |    17264 | data_etl | Debezium Streaming | 172.21.0.1  |                 |       59396 | 2025-01-07 03:04:54.449307+00 |              |       |          |           |           |            |           |           |            |               |            | 
(1 row)

