#!/usr/bin/env bash

echo "# install IRkernel"
# https://github.com/IRkernel/IRkernel
# http://irkernel.github.io/installation/

sudo R -e "install.packages(c('rzmq','repr','IRkernel','IRdisplay'), repos = c('http://irkernel.github.io/', 'http://cran.rstudio.com/'))"
#su vagrant -c "R -e 'IRkernel::installspec()' "
#sudo -u vagrant sh -c "R -e 'IRkernel::installspec()' "
sudo su vagrant -c "R -e 'IRkernel::installspec()' "
