#! /bin/bash


cd ${NIFI_HOME} && ./bin/nifi.sh start && tail -f ./logs/nifi-app.log