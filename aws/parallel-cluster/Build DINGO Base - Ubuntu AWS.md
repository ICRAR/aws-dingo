# Build the DINGO Base

## Create the instances

Start the instance

## Update the Ubuntu
```
sudo apt update
sudo apt upgrade
```

If necessary to bring it to 18.04
```
sudo apt update && sudo apt dist-upgrade
sudo apt install update-manager-core
```
REBOOT

```
do-release-upgrade
```

## Clone YANDASOFT

```
git clone https://bitbucket.csiro.au/scm/askapsdp/yandasoft.git
```

### Add the missing packages

Casacore needs
```
sudo apt -y install libboost-all-dev python-numpy
```
LOFAR needs
```
sudo apt -y install libxerces-c-dev libhdf5-dev libhdf5-serial-dev
```

### Build YandaSoft
```
cd yandasoft 

sudo bash build_all.sh -s ubuntu -S -c -a -r -y -j X
```

## Clone cloud-dingo
```
git clone https://github.com/ICRAR/cloud-dingo.git
```

### Install the AWS CLI
```
sudo pip install awscli
```


### Create the config file

DO NOT do this on a image that becomes and AMI

```
aws configure
```
