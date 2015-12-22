#!/usr/bin/env bash

echo "# install RISE"
# https://github.com/damianavila/RISE
#RISE_URL=https://github.com/damianavila/RISE/archive
#RISE_FILE=master.zip
#RISE_DIR=RISE-master
#TEMP_DIR=/tmp

#cd $TEMP_DIR
#wget -q -c $RISE_URL/$RISE_FILE
#unzip $RISE_FILE
#cd $RISE_DIR

RISE_GIT=https://github.com/damianavila/RISE.git
APPS_DIR=/vagrant/apps
#RISE_HOME=/tmp/
RISE_HOME=$APPS_DIR/rise

if ! [ -d $RISE_HOME ]; then
#  git clone $RISE_GIT $RISE_HOME
  sudo git clone $RISE_GIT $RISE_HOME
fi
cd $RISE_HOME
#sudo python setup.py install
#su vagrant -c "python setup.py install"
#sudo -u vagrant sh -c "python setup.py install"
sudo su vagrant -c "python setup.py install"
