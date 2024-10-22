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
    vim \
    openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin

# local tar
COPY ranger-2.4.0-admin.tar.gz /tmp/ranger-2.4.0-admin.tar.gz

RUN set -x && tar -xvf /tmp/ranger-2.4.0-admin.tar.gz -C /tmp/ \
    && mv /tmp/ranger-2.4.0-admin /opt/ranger \
    && rm /tmp/ranger-2.4.0-admin.tar.gz

COPY postgresql-42.5.4.jar /opt/ranger/postgresql-42.5.4.jar


RUN sed -i 's|^DB_FLAVOR=.*|DB_FLAVOR=POSTGRES|' /opt/ranger/install.properties
RUN sed -i 's|^SQL_CONNECTOR_JAR=.*|SQL_CONNECTOR_JAR=/opt/ranger/postgresql-42.5.4.jar|' /opt/ranger/install.properties
RUN sed -i 's|^db_root_user=.*|db_root_user=postgres|' /opt/ranger/install.properties
RUN sed -i 's|^db_root_password=.*|db_root_password=123456|' /opt/ranger/install.properties
RUN sed -i 's|^db_host=.*|db_host=172.25.1.13|' /opt/ranger/install.properties
RUN sed -i 's|^db_password=.*|db_password=ranger|' /opt/ranger/install.properties


RUN sed -i 's/^rangerAdmin_password=.*/rangerAdmin_password=Rangeradmin1/' /opt/ranger/install.properties
RUN sed -i 's/^rangerTagsync_password=.*/rangerTagsync_password=Rangeradmin1/' /opt/ranger/install.properties
RUN sed -i 's/^rangerUsersync_password=.*/rangerUsersync_password=Rangeradmin1/' /opt/ranger/install.properties
RUN sed -i 's/^keyadmin_password=.*/keyadmin_password=Rangeradmin1/' /opt/ranger/install.properties

RUN sed -i 's|^audit_store=.*|audit_store=|' /opt/ranger/install.properties


RUN sed -i 's|^policymgr_external_url=.*|policymgr_external_url=http://172.25.1.16:6080|' /opt/ranger/install.properties

RUN sed -i 's/^unix_user=.*/unix_user=root/' /opt/ranger/install.properties
RUN sed -i 's/^unix_user_pwd=.*/unix_user_pwd=root/' /opt/ranger/install.properties
RUN sed -i 's/^unix_group=.*/unix_group=root/' /opt/ranger/install.properties



ADD ranger/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
