#!/bin/bash


cd /opt/ranger && ./setup.sh 
# /opt/ranger/ews/start-ranger-admin.sh

/usr/bin/ranger-admin start

tail -f /dev/null

exec $@
