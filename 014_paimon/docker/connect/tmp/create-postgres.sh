long@hello:~$ docker exec -it 975 bash
root@postgres:/# su - postgres
postgres@postgres:~$ psql -U admin -d postgres 
postgres=# CREATE ROLE data_etl
WITH
LOGIN
REPLICATION
CONNECTION LIMIT -1
PASSWORD 'data_etl'; 
postgres=# \conninfo
You are connected to database "postgres" as user "admin" via socket in "/var/run/postgresql" at port "5432".
postgres=# \dRp+
                       Publication dbz_publication
 Owner | All tables | Inserts | Updates | Deletes | Truncates | Via root 
-------+------------+---------+---------+---------+-----------+----------
 admin | t          | t       | t       | t       | t         | f
(1 row)

postgres=# \l
                                              List of databases
    Name     | Owner | Encoding |  Collate   |   Ctype    | ICU Locale | Locale Provider | Access privileges 
-------------+-------+----------+------------+------------+------------+-----------------+-------------------
 hive_db     | admin | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | 
 my_database | admin | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | 
 postgres    | admin | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | 
 template0   | admin | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/admin         +
             |       |          |            |            |            |                 | admin=CTc/admin
 template1   | admin | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/admin         +
             |       |          |            |            |            |                 | admin=CTc/admin
(5 rows)

postgres=# \c my_database 
You are now connected to database "my_database" as user "admin".
my_database=# \dRp+
Did not find any publications.

-> nhớ là phải chuyển db trước khi tạo publication

my_database=# CREATE PUBLICATION dbz_publication FOR ALL TABLES;
CREATE PUBLICATION
my_database=# \dRp+
                       Publication dbz_publication
 Owner | All tables | Inserts | Updates | Deletes | Truncates | Via root 
-------+------------+---------+---------+---------+-----------+----------
 admin | t          | t       | t       | t       | t         | f
(1 row)


-> báo lỗi Caused by: org.postgresql.util.PSQLException: ERROR: must be owner of publication dbz_publication
-> cần chuyển owner của cái publication này

my_database=# DROP PUBLICATION  IF EXISTS dbz_publication;
DROP PUBLICATION
my_database=# \dRp+
Did not find any publications.
postgres@postgres:~$ psql -U data_etl -d my_database 
psql (15.10 (Debian 15.10-1.pgdg120+1))
Type "help" for help.

my_database=> CREATE PUBLICATION dbz_publication FOR ALL TABLES;
ERROR:  permission denied for database my_database

postgres@postgres:~$ psql -U admin -d postgres 
psql (15.10 (Debian 15.10-1.pgdg120+1))
Type "help" for help.


-> user không có quyền tạo -> tạo bằng admin vào chuyển owner cho user thường

postgres=# \c my_database
You are now connected to database "my_database" as user "admin".
my_database=# CREATE PUBLICATION dbz_publication FOR ALL TABLES;
CREATE PUBLICATION
my_database=# ALTER PUBLICATION dbz_publication owner to  data_etl;
ALTER PUBLICATION
my_database=# \dRp+
                        Publication dbz_publication
  Owner   | All tables | Inserts | Updates | Deletes | Truncates | Via root 
----------+------------+---------+---------+---------+-----------+----------
 data_etl | t          | t       | t       | t       | t         | f
(1 row)


-> vẫn k được






