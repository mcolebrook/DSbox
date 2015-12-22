#!/usr/bin/env bash

MASTER="local[*]"
#MASTER="spark://spark-master:7077"
NUM_EXECUTORS=12   # 24
EXECUTOR_CORES=2
EXECUTOR_MEMORY="1g"  # 10g
DRIVER_MEMORY="1536M"

# ensure that always chmod go-wrx
umask 0077


DEFAULT_PYSPARK_SUBMIT_ARGS="--packages com.databricks:spark-csv_2.10:1.3.0 --driver-memory $DRIVER_MEMORY --num-executors $NUM_EXECUTORS --executor-cores $EXECUTOR_CORES --executor-memory $EXECUTOR_MEMORY"
PYSPARK_SUBMIT_ARGS="--master $MASTER $DEFAULT_SUBMIT_ARGS"

export PYSPARK_PYTHON=python
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS="notebook --ip='*' --port=8001 --no-browser" 

#echo $PYSPARK_SUBMIT_ARGS $DEFAULT_PYSPARK_SUBMIT_ARGS $PYSPARK_DRIVER_PYTHON $PYSPARK_DRIVER_PYTHON_OPTS
pyspark $PYSPARK_SUBMIT_ARGS
