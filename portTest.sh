#!/usr/bin/env bash

# 检查远程计算机是否正在侦听端口
# Reference: https://albertotb.com/bash-test-if-port-22-is-open/

# 用法: ./Test_port.sh HOST PORT
host=$1
port=$2

timeout=5

if (( "$#" != 2 )); then
   echo "usage: $(basename $0) HOST PORT"
   exit 1
fi


if nc -w $timeout -z $host $port; then
   echo "Yes"
else
   echo "No"
fi
