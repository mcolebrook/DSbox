#!/usr/bin/env bash

HOME=/vagrant

echo "# update system"
sudo apt-get -y update
sudo apt-get -y upgrade

echo "# install git + unzip"
sudo apt-get -y install git unzip

echo "# create directory to save apps"
if ! [ -d $HOME/apps ]; then
#  su vagrant mkdir $HOME/apps
#  sudo su vagrant -c "mkdir $HOME/apps"
  sudo -u vagrant mkdir $HOME/apps
fi

# install sbt
# http://www.scala-sbt.org/0.13/tutorial/Installing-sbt-on-Linux.html
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
sudo apt-get -y update
sudo apt-get -y install sbt
