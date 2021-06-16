FROM ubuntu:18.04

# install supported tools
RUN apt-get update && apt-get install -y --no-install-recommends\
    curl \
    net-tools \
    telnet \
    iputils-ping \
    nano \
    ssh \
    && rm -rf /var/lib/apt/lists/*

# install java-8
RUN apt-get update && apt-get install -y openjdk-8-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH $PATH:$JAVA_HOME/bin

# passwordless ssh
ENV PDSH_RCMD_TYPE=ssh
RUN rm -f /root/.ssh/id_rsa
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys
RUN /etc/init.d/ssh start

CMD ["/bin/bash"]