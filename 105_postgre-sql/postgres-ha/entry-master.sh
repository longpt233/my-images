#! /bin/bash


/usr/lib/postgresql/15/bin/pg_ctl -D /data/postgresql -l /data/postgresql/log/logfile start    

psql -c "CREATE ROLE replica_user WITH REPLICATION LOGIN PASSWORD 'password';"



sudo su - exporter
export DATA_SOURCE_NAME='postgresql://postgres@localhost:5432/?sslmode=disable'
/opt/postgres_exporter/postgres_exporter-0.12.0.linux-amd64/postgres_exporter --web.listen-address=:9187 --web.telemetry-path=/metrics