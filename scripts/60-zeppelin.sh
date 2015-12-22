#!/usr/bin/env bash

echo "# before installing Zeppelin, we need to install Maven >= 3.1.0"
# http://askubuntu.com/questions/420281/how-to-update-maven-3-0-4-3-1-1
#MAVEN_URL=http://www.eu.apache.org/dist/maven/maven-3/3.1.1/binaries
MAVEN_URL=http://www.eu.apache.org/dist/maven/maven-3/3.3.3/binaries
MAVEN_FILE=apache-maven-3.3.3
MAVEN_HOME=/opt/maven
APPS_DIR=/vagrant/apps

if ! [ -f $APPS_DIR/$MAVEN_FILE-bin.tar.gz ] ; then
  #sudo wget -q -P /opt -c $MAVEN_URL/$MAVEN_FILE-bin.tar.gz
  sudo wget -q -P $APPS_DIR -c $MAVEN_URL/$MAVEN_FILE-bin.tar.gz
fi
sudo tar xzvf $APPS_DIR/$MAVEN_FILE-bin.tar.gz -C /opt
#sudo rm $MAVEN_FILE-bin.tar.gz
cd /opt
sudo ln -s $MAVEN_FILE maven

echo "# install Zeppelin"
HOME=/home/vagrant
ZEPPELIN_GIT=https://github.com/apache/incubator-zeppelin.git
#ZEPPELIN_HOME=$HOME/zeppelin
ZEPPELIN_HOME=/opt/zeppelin

sudo apt-get -y update
sudo apt-get -y install npm libfontconfig

sudo git clone $ZEPPELIN_GIT $ZEPPELIN_HOME
# checkout to version 0.5.5
sudo git checkout e4743e71d2421f5b6950f9e0f346f07bb84f1671

# avoid problems connecting to git
sudo git config --global url."https://".insteadOf git://

if [ -z "$SPARK_HOME" ]; then
  export SPARK_HOME=/opt/spark
fi

export PATH=$MAVEN_HOME/bin:$PATH
cd $ZEPPELIN_HOME
sudo env "PATH=$PATH" mvn clean package -Pspark-1.5 -DskipTests 
# avoid problems with %dep
sudo mkdir $ZEPPELIN_HOME/local-repo
sudo chmod a+w,+t $ZEPPELIN_HOME/local-repo

#sudo sh -c 'cat > ${ZEPPELIN_HOME}/conf/zeppelin-env.sh <<EOF
#!/bin/bash
#export SPARK_HOME="/opt/spark"
#export ZEPPELIN_MEM="-Xmx1024m"
#export ZEPPELIN_JAVA_OPTS="-Dspark.home=/opt/spark"
#export ZEPPELIN_NOTEBOOK_DIR="/vagrant/zeppelin_notebooks"
#export ZEPPELIN_LOG_DIR="/tmp/zeppelin-logs"
#export ZEPPELIN_PID_DIR="/tmp/zeppelin-pids"

## avoid conflict with SPARK_MASTER_WEBUI_PORT default value 8080
#export ZEPPELIN_PORT="8888"

##export SPARK_SUBMIT_OPTIONS=
##export PYSPARK_PYTHON=$SPARK_HOME/bin/pyspark
##export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.8.2.1-src.zip
#EOF'

cd $ZEPPELIN_HOME/..
sudo ln -s /vagrant/scripts/zeppelin-env.sh $ZEPPELIN_HOME/conf/zeppelin-env.sh

# this is the only way to make zeppelin start OK
#sudo chown -R vagrant:vagrant $ZEPPELIN_HOME
#sudo env "PATH=$PATH" /opt/zeppelin/bin/zeppelin-daemon.sh start
#/opt/zeppelin/bin/zeppelin-daemon.sh start
