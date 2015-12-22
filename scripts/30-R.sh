#!/usr/bin/env bash
#https://cran.r-project.org/bin/linux/ubuntu/README

echo "# install latest version of R"
# https://pythonandr.wordpress.com/2015/04/27/upgrading-to-r-3-2-0-on-ubuntu/
# https://cran.r-project.org/bin/linux/ubuntu/

R_REPO="deb http://cran.rstudio.com/bin/linux/ubuntu trusty/"

sudo add-apt-repository "$R_REPO"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9
sudo add-apt-repository -y ppa:marutter/rdev

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install r-base
sudo apt-get -y clean

# allow user vagrant to install packages
sudo chmod 777 /usr/local/lib/R/site-library
