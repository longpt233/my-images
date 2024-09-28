FROM ubuntu:22.04


USER root
WORKDIR /


ADD apt.conf /etc/apt/apt.conf.d/10apt.conf


RUN apt-get update && apt install -y --no-install-recommends\
    curl \
    net-tools \
    telnet \
    iputils-ping \
    nano \
    ssh  \
    curl \
    ca-certificates \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*


RUN install -d /usr/share/postgresql-common/pgdg \
&& curl -x "http://10.208.164.185:9999" -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc  \
&& cat /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc \
&& sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' 

ENV DEBIAN_FRONTEND=noninteractive  
# advoid : Please select the geographic area

RUN  apt-get update \
&& apt -y install postgresql-15 


# RUN systemctl stop postgresql \
# 
RUN  rm -rf /var/lib/postgresql &&  mkdir -p /data  && chown -R postgres. /data

# RUN cp /etc/postgresql/15/main/postgresql.conf /data/postgresql/postgresql.conf

# RUN cp /etc/postgresql/15/main/pg_hba.conf /data/postgresql/pg_hba.conf


USER postgres

RUN /usr/lib/postgresql/15/bin/initdb -D /data/postgresql

RUN current_day=$(date +"%d-%m-%Y") && cp /data/postgresql/postgresql.conf /data/postgresql/postgresql.conf.bk.$current_day

# RUN sed -i "s|data_directory = '/var/lib/postgresql/15/main'|data_directory = '/data/postgresql'|g"  /data/postgresql/postgresql.conf 
# RUN sed -i "s|hba_file = '/etc/postgresql/15/main/pg_hba.conf'|hba_file = '/data/postgresql/pg_hba.conf'|g"    /data/postgresql/postgresql.conf 
# RUN sed -i "s|ident_file = '/etc/postgresql/15/main/pg_ident.conf'|ident_file = '/data/postgresql/pg_ident.conf'|g"  /data/postgresql/postgresql.conf 
# RUN sed -i "s|#listen_addresses = 'localhost'|listen_addresses = '*'	|g"  /data/postgresql/postgresql.conf 

RUN sed -i "s|#data_directory = 'ConfigDir'|data_directory = '/data/postgresql'|g"  /data/postgresql/postgresql.conf 
RUN sed -i "s|#hba_file = 'ConfigDir/pg_hba.conf'|hba_file = '/data/postgresql/pg_hba.conf'|g"    /data/postgresql/postgresql.conf 
RUN sed -i "s|#ident_file = 'ConfigDir/pg_ident.conf'|ident_file = '/data/postgresql/pg_ident.conf'|g"  /data/postgresql/postgresql.conf 
RUN sed -i "s|#listen_addresses = 'localhost'|listen_addresses = '*'	|g"  /data/postgresql/postgresql.conf 

RUN sed -i "s|#wal_level = replica|wal_level = replica|g"  /data/postgresql/postgresql.conf 
RUN sed -i "s|#archive_mode = off|archive_mode = on|g"  /data/postgresql/postgresql.conf 
RUN sed -i "s|#archive_command = ''|archive_command = 'cp %p /data/postgresql/archive/%f'|g"  /data/postgresql/postgresql.conf 
RUN sed -i "s|#hot_standby = on|hot_standby = on|g"  /data/postgresql/postgresql.conf 

RUN sed -i "s|#log_directory = 'log'|log_directory = '/data/postgresql/log'|g"  /data/postgresql/postgresql.conf 
RUN sed -i "s|#log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'|log_filename = logfile|g"  /data/postgresql/postgresql.conf 
RUN sed -i "s|log_timezone = 'Etc/UTC'|log_timezone = 'Asia/Ho_Chi_Minh'|g"  /data/postgresql/postgresql.conf 

# RUN diff /data/postgresql/postgresql.conf  /data/postgresql/postgresql.conf 

# RUN current_day=$(date +"%d-%m-%Y") && mv /data/postgresql/postgresql.conf /data/postgresql/postgresql.conf.bk.$current_day \
# && mv /data/postgresql/postgresql.conf  /data/postgresql/postgresql.conf \
# && ls -la /data/postgresql/postgres*

# RUN chown postgres:postgres -R /data/postgresql

RUN echo "host    all             all             0.0.0.0/0            md5" >> /data/postgresql/pg_hba.conf
RUN echo "host  replication   replica_user        172.26.0.105/24   md5" >> /data/postgresql/pg_hba.conf
RUN echo "host  replication   replica_user        172.26.0.106/24   md5" >> /data/postgresql/pg_hba.conf

USER root

ADD ./entry-master.sh /data/entry-master.sh
ADD ./entry-slave.sh /data/entry-slave.sh

RUN chmod +x /data/entry-master.sh /data/entry-slave.sh
RUN chown postgres. /data/entry*


ADD wgetrc /etc/wgetrc 
RUN adduser exporter
RUN mkdir /opt/postgres_exporter
RUN cd /opt/postgres_exporter \ 
&& wget https://github.com/prometheus-community/postgres_exporter/releases/download/v0.12.0/postgres_exporter-0.12.0.linux-amd64.tar.gz  \
&&  tar -xzvf postgres_exporter-0.12.0.linux-amd64.tar.gz \
&& chown exporter:exporter -R /opt/postgres_exporter 


USER postgres

RUN mkdir /data/postgresql/archive
RUN mkdir /data/postgresql/log

ENTRYPOINT tail -f /dev/null
