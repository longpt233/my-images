FROM debezium/postgres:11

COPY ./setup.sql /home/setup.sql
COPY ./fake.sql /home/fake.sql
COPY ./init.sh /docker-entrypoint-initdb.d/init-db.sh