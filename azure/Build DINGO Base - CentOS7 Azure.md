# Build the DINGO Base

## Create the instances

Start the instance from the azure portal

## Update the CentOS and add EPEL
```
sudo yum -y upgrade
sudo yum -y install epel-release
```

## Clone YANDASOFT

```
sudo yum -y install git
git clone https://bitbucket.csiro.au/scm/askapsdp/yandasoft.git
```

### Add the missing packages

Build needs
```
sudo yum -y install lapack-devel.x86_64 lapack.x86_64 python2-numpy xerces-c-devel hdf5-devel
```

### CMake 

Casacore python has a dependence on Numpy, but CMake 3.13 (the default with CentOS7)  
can't read the dependence as it was introduced in 3.14 - so after the first failure you need to edit CMakeLists.txt 
to require 3.15

```
cd yandasoft
git clone https://github.com/casacore/casacore
cd casacore/python 
vim CMakeLists.txt
```

### Build YandaSoft
```
cd ~/yandasoft 

sudo ./build_all.sh -s centos -S -c -a -r -y -j X
```

## Clone cloud-dingo
```
cd ~
git clone https://github.com/ICRAR/cloud-dingo.git
```
