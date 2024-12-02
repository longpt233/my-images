#!/bin/bash

echo ""

echo -e "\nbuild docker hbase image\n"
sudo docker build -t dinhphu/hbase:1.0 .

echo ""