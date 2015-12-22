#!/usr/bin/env bash

echo "# install test_helper"

#TEST_HELPER_URL=https://github.com/hpec/test_helper/archive
#TEST_HELPER_FILE=master.zip
#TEST_HELPER_DIR=test_helper-master
#TEMP_DIR=/tmp

#cd $TEMP_DIR
#wget -q -c $TEST_HELPER_URL/$TEST_HELPER_FILE
#unzip $TEST_HELPER_FILE
#cd $TEST_HELPER_DIR

TEST_HELPER_GIT=https://github.com/hpec/test_helper.git
APPS_DIR=/vagrant/apps
#TEST_HELPER_HOME=/tmp/test_helper
TEST_HELPER_HOME=$APPS_DIR/test_helper

if ! [ -d $TEST_HELPER_HOME ]; then
#  git clone $TEST_HELPER_GIT $TEST_HELPER_HOME
  sudo git clone $TEST_HELPER_GIT $TEST_HELPER_HOME
fi

cd $TEST_HELPER_HOME
sudo python setup.py install
#sudo -u vagrant sh -c "python setup.py install"
