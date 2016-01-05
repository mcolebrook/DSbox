#!/usr/bin/env bash

echo "# install java"
JAVA_JDK=openjdk-7-jdk
HOME=/home/vagrant
BASHRC=$HOME/.bashrc

if [ "$SYSTEM" == "x86_64" ]; then 
  JAVA_DIR=/usr/lib/jvm/java-7-openjdk-amd64
else
  JAVA_DIR=/usr/lib/jvm/java-7-openjdk-i386
fi

sudo apt-get -y install "$JAVA_JDK" libjansi-java

export JAVA_HOME=$JAVA_DIR

#if ! [ "$JAVA_HOME" ]; then
if ! grep -q 'export JAVA_HOME' $BASHRC; then
  echo "export JAVA_HOME=$JAVA_HOME" >> $BASHRC
fi

echo "# install python"
sudo apt-get -y install build-essential python-pip python-dev python3-pip python3-dev libzmq3 libzmq3-dev
#libfreetype6-dev libxft-dev

TEMP_DIR=/tmp

echo "# install scala 2.10"
wget -q -P $TEMP_DIR -c http://downloads.typesafe.com/scala/2.10.6/scala-2.10.6.deb
sudo dpkg -i $TEMP_DIR/scala-2.10.6.deb
rm $TEMP_DIR/scala-2.10.6.deb

