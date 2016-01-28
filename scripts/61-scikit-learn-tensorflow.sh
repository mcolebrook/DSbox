#!/usr/bin/env bash

SYSTEM=`uname -m`

sudo apt-get -y install python-numpy python-scipy 
sudo apt-get -y install python3-numpy python3-scipy

echo "# installing scikit-learn"
sudo pip install scikit-learn
sudo pip3 install scikit-learn

# install tensorflow
if [ "$SYSTEM" == "x86_64" ]; then
  echo "# installing TensorFlow"
  sudo pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.6.0-cp27-none-linux_x86_64.whl
  sudo pip3 install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.6.0-cp34-none-linux_x86_64.whl  
fi

