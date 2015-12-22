#!/usr/bin/env bash

echo # install RStudio Server
# https://www.rstudio.com/products/rstudio/download-server/
# http://tuxette.nathalievilla.org/?p=1606
# gabrielebaldassarre.com/2015/07/07/how-to-install-rstudio-server-in-a-production-ready-ubuntu-environment/

RSTUDIO_SERVER_FILE=rstudio-server-0.99.486-i386.deb
RSTUDIO_SERVER_URL="https://download2.rstudio.org/$RSTUDIO_SERVER_FILE"
#TEMP_DIR=/tmp
APPS_DIR=/vagrant/apps

sudo apt-get -y install gdebi-core

if ! [ -f $RSTUDIO_SERVER_FILE ]; then
  #sudo wget -q -P $TEMP_DIR -c $RSTUDIO_SERVER_URL
  sudo wget -q -P $APPS_DIR -c $RSTUDIO_SERVER_URL
fi

#sudo gdebi -n $TEMP_DIR/$RSTUDIO_SERVER_FILE
sudo gdebi -n $APPS_DIR/$RSTUDIO_SERVER_FILE
sudo apt-get clean
