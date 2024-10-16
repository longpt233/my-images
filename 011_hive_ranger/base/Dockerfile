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
    openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

# install java-8
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH $PATH:$JAVA_HOME/bin

RUN apt-get update && apt install -y vim

ENTRYPOINT ["tail","-f", "/dev/null"]