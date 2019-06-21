#!/usr/bin/env bash

# This needs to be have done first
# git clone https://github.com/ICRAR/cloud-dingo.git

sudo apt -y update
sudo apt -y upgrade

git clone https://bitbucket.csiro.au/scm/askapsdp/yandasoft.git

sudo apt-get install -y libboost-all-dev
sudo apt install -y python-numpy
sudo apt install -y libxerces-c-dev
sudo apt install -y libhdf5-dev libhdf5-serial-dev

cd yandasoft

sudo bash build_all.sh -s ubuntu -S -c -a -r -y -j 4

sudo pip install awscli
