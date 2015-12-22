#!/usr/bin/env bash

#use: vagrant ssh spark-master -c "bash /opt/zeppelin/bin/zeppelin-daemon.sh start"
sudo env "PATH=$PATH" /opt/zeppelin/bin/zeppelin-daemon.sh start
