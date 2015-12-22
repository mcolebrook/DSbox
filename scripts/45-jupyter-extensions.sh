#!/usr/bin/env bash

echo "# install jupyter extensions"

JUPYTER_EXT_GIT=https://github.com/ipython-contrib/IPython-notebook-extensions.git
APPS_DIR=/vagrant/apps
JUPYTER_EXT_HOME=$APPS_DIR/test_helper

sudo pip2 install psutil pyyaml
sudo pip3 install psutil pyyaml


if ! [ -d $JUPYTER_EXT_HOME ]; then
  sudo git clone $JUPYTER_EXT_GIT $JUPYTER_EXT_HOME
fi

cd $JUPYTER_EXT_HOME
sudo su vagrant -c "python setup.py install"
