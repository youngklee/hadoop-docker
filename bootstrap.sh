#!/bin/bash

service ssh start
$HADOOP_PREFIX/sbin/start-dfs.sh
bash
