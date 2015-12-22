#!/bin/bash
export SPARK_HOME="/opt/spark"
#export ZEPPELIN_MEM="-Xmx1024m"
export ZEPPELIN_MEM="-Xmx2g"
export ZEPPELIN_JAVA_OPTS="-Dspark.home=/opt/spark"
export ZEPPELIN_NOTEBOOK_DIR="/vagrant/zeppelin_notebooks"
#export ZEPPELIN_NOTEBOOK_DIR="/vagrant/zeppelin-notebooks-master"
export ZEPPELIN_LOG_DIR="/tmp/zeppelin-logs"
export ZEPPELIN_PID_DIR="/tmp/zeppelin-pids"

# avoid conflict with SPARK_MASTER_WEBUI_PORT default value 8080
export ZEPPELIN_PORT="8888"

#export SPARK_SUBMIT_OPTIONS=
#export PYSPARK_PYTHON=/opt/spark/bin/pyspark
#export PYTHONPATH=/opt/spark/python:/opt/spark/python/lib/py4j-0.8.2.1-src.zip
