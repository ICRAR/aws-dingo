#!/usr/bin/env bash

# This needs to be have done first
# git clone https://github.com/ICRAR/aws-dingo.git

cd ~
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get --yes install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo apt-get --yes install docker-ce

sudo docker pull sord/askapsoft:with_mssplit

cd cloud-dingo/docker/askapsoft-mpi
sudo docker build .