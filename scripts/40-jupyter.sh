#!/usr/bin/env bash

echo "# install jupyter"

#ANACONDA_URL=https://repo.continuum.io/archive
#ANACONDA_FILE=Anaconda3-2.3.0-Linux-x86.sh
#ANACONDA_DIR=/opt/anaconda
#TEMP_DIR=/tmp

HOME=/home/vagrant
BASHRC=$HOME/.bashrc

#sudo wget -q -P $TEMP_DIR -c $ANACONDA_URL/$ANACONDA_FILE
#sudo bash $ANACONDA_FILE -b -p $ANACONDA_DIR
#sudo $ANACONDA_DIR/bin/conda install -y jupyter
#sudo $ANACONDA_DIR/bin/conda clean -yt

# install jupyter with python3 as default kernel
# http://totoprojects.blogspot.com.es/ 
# http://stackoverflow.com/questions/30492623/using-both-python-2-x-and-python-3-x-in-ipython-notebook
# https://github.com/ipython/ipython/pull/8877
# https://github.com/jupyter/jupyter/issues/52
sudo pip3 install jupyter

# install ipython2 ...
sudo pip install jupyter

# ... and then install python2 kernel in jupyter
# THIS LINE WON'T WORK!! #sudo ipython2 kernelspec install-self
# try this:
sudo python2 -m ipykernel install

# create config
#$ANACONDA_DIR/bin/jupyter notebook --generate-config
#su vagrant -c "jupyter notebook --generate-config"
#sudo -u vagrant sh -c "jupyter notebook --generate-config"
sudo su vagrant -c "jupyter notebook --generate-config"

# overwrite default config
#su vagrant -c "cat > $HOME/.jupyter/jupyter_notebook_config.py <<EOF
#sudo -u vagrant sh -c "cat > /home/vagrant/.jupyter/jupyter_notebook_config.py <<EOF
sudo su vagrant -c "cat > $HOME/.jupyter/jupyter_notebook_config.py <<EOF
#import os
#c = get_config()
#c.NotebookApp.ip = os.getenv('INTERFACE', '') or '*'
#c.NotebookApp.port = int(os.getenv('PORT', '') or 8001)

c.NotebookApp.ip = '*'
c.NotebookApp.port = 8001
c.NotebookApp.open_browser = False
EOF"

# change owner of /home/vagrant/.local
sudo chown -R vagrant:vagrant $HOME/.local 

# install matplotlib
#sudo apt-get build-dep matplotlib
#sudo pip install matplotlib
#sudo pip3 install matplotlib 

sudo apt-get -y install python-matplotlib python-numpy python-scipy
sudo apt-get -y install python3-matplotlib python3-numpy python3-scipy

#echo "export PATH=$PATH:$ANACONDA_DIR/bin" >> $BASHRC
#echo "export PYTHONPATH=/usr/local/lib/python2.7/dist-packages:/opt/anaconda/lib/python2.7/site-packages:$PYTHONPATH" >> $BASHRC

# use: vagrant ssh spark-master -c "jupyter-notebook"
