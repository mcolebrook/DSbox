#!/usr/bin/env bash

echo "# install Spark"
SPARK_VER=1.5.2
HADOOP_VER=2.6
SPARK_DIST=spark-$SPARK_VER-bin-hadoop$HADOOP_VER
SPARK_URL="http://www.eu.apache.org/dist/spark/spark-$SPARK_VER/$SPARK_DIST.tgz"
#TEMP_DIR=/tmp
INSTALL_DIR=/opt
HOME=/home/vagrant
BASHRC=$HOME/.bashrc
APPS_DIR=/vagrant/apps

if ! [ -f $APPS_DIR/$SPARK_DIST.tgz ]; then
  #sudo wget -q -P $TEMP_DIR -c $SPARK_URL
  sudo wget -q -P $APPS_DIR -c $SPARK_URL
fi
#sudo tar xzvf $TEMP_DIR/$SPARK_DIST.tgz
sudo tar xzvf $APPS_DIR/$SPARK_DIST.tgz -C $INSTALL_DIR
cd $INSTALL_DIR
sudo ln -s $SPARK_DIST spark
sudo chown -R root:root $SPARK_DIST

export SPARK_HOME=${INSTALL_DIR}/spark
if ! grep -q 'export SPARK_HOME' $BASHRC; then
  echo "export SPARK_HOME=${SPARK_HOME}" >> $BASHRC
fi

#if ! grep -q 'export SPARK_LOCAL_IP' $BASHRC; then
#  echo "export SPARK_LOCAL_IP=localhost" >> $BASHRC
#fi

if ! grep -q 'export PATH=$PATH:$SPARK_HOME/bin' $BASHRC; then
  echo "export PATH=$PATH:$SPARK_HOME/bin" >> $BASHRC
fi

#echo "export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.8.2.1-src.zip:$PYTHONPATH" >> $BASHRC
if ! grep -q 'export PYTHONPATH' $BASHRC; then
  PY4J=$(basename $(find $SPARK_HOME/python/lib/*.zip))
  echo "export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/$PY4J:$PYTHONPATH" >> $BASHRC
fi

# link $SPARK_HOME/conf/spark-env.sh file to /vagrant home
sudo ln -s /vagrant/scripts/spark-env.sh $SPARK_HOME/conf/spark-env.sh

#$SPARK_HOME/sbin/start-all.sh
