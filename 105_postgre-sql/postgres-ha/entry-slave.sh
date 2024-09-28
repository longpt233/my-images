#! /bin/bash

rm -rf /data/postgresql
/usr/lib/postgresql/15/bin/pg_basebackup -h 172.26.0.105 -U replica_user -X stream -C -S replica_1 -v -R -W -D /data/postgresql   
dien pass  password
/usr/lib/postgresql/15/bin/pg_ctl -D /data/postgresql -l /data/postgresql/logfile start   