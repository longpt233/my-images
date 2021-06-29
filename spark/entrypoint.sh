#!/usr/bin/env bash

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
# sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
# /etc/init.d/ssh start
# echo -e "1\n1" | passwd

export HADOOP_CONF_DIR=/opt/spark/conf/hadoop-conf
cd /opt/spark

tail -f /dev/null
exec $@