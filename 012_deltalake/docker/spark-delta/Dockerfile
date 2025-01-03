FROM ubuntu:20.04

USER root
WORKDIR /


ADD apt.conf /etc/apt/apt.conf.d/10apt.conf

# install supported tools
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    net-tools \
    telnet \
    iputils-ping \
    nano \
    ssh \
    krb5-user \
    openjdk-8-jdk \
    sudo  \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --proxy http://10.60.117.103:8085 jupyterlab

RUN pip3 install --proxy http://10.60.117.103:8085 pyspark==3.3.1


ADD spark-delta/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]