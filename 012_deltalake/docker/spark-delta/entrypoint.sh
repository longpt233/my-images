#!/bin/bash

# run notebook
nohup python3 -m jupyterlab --ip=0.0.0.0 --port=18080 --NotebookApp.token=1111 --allow-root > /dev/null &

# tail -f  $HBASE_HOME/log
tail -f /dev/null  # lenh nay de treo shell -> khong thoat container 
exec $@