#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install gfortran

sudo apt-get install python-dev
sudo apt-get install flex bison openmpi-bin libopenmpi-dev libfreetype6-dev libpng-dev

#=== Things that specific to Ubuntu ===
#autoconf
sudo apt-get install --yes autoconf
#pkg-config
sudo apt-get install --yes pkg-config
#scons
sudo apt-get install --yes scons
#ant
sudo apt-get install --yes ant
#ant-optional
sudo apt-get install --yes ant-optional
#libatlas-base-dev
sudo apt-get install --yes libatlas-base-dev

git clone https://ord006@bitbucket.csiro.au/scm/casssoft/askapsoft.git

cd ~/askapsoft/Code/Systems/rialto
rbuild -S -a -v

cd askapsoft
/usr/bin/python bootstrap.py -n

cd ~/askapsoft/Code/Systems/rialto
rbuild -S -a -v

. initaskap.sh
rbuild -S -a
