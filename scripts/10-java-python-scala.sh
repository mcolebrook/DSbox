#!/usr/bin/env bash

echo "# install java"
JAVA_JDK=openjdk-7-jdk
HOME=/home/vagrant
BASHRC=$HOME/.bashrc
JAVA_DIR=/usr/lib/jvm/java-7-openjdk-i386
SYSTEM=`uname -m`

if [ "$SYSTEM" == "x86_64" ]; then 
  JAVA_DIR=/usr/lib/jvm/java-7-openjdk-amd64
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

# install tensorflow
if [ "$SYSTEM" == "x86_64" ]; then
  echo "# installing TensorFlow"
  sudo pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.6.0-cp27-none-linux_x86_64.whl
  sudo pip3 install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.6.0-cp34-none-linux_x86_64.whl  
fi


TEMP_DIR=/tmp

echo "# install scala 2.10"
wget -q -P $TEMP_DIR -c http://downloads.typesafe.com/scala/2.10.6/scala-2.10.6.deb
sudo dpkg -i $TEMP_DIR/scala-2.10.6.deb
rm $TEMP_DIR/scala-2.10.6.deb

