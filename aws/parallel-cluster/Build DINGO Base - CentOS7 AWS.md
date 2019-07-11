# Build the DINGO Base

## Create the instances

Start the from the list of valid CentOS7 [AMIs](https://github.com/aws/aws-parallelcluster/blob/v2.3.1/amis.txt)

## Update the CentOS and add EPEL
```
sudo yum -y upgrade
sudo yum -y install epel-release
```

## Clone YANDASOFT

```
git clone https://bitbucket.csiro.au/scm/askapsdp/yandasoft.git
```

### Add the missing packages

Build needs
```
sudo yum -y install lapack-devel.x86_64 lapack.x86_64 python2-numpy xerces-c-devel hdf5-devel
```

### CMake 

Casacore python has a dependence on Numpy, but CMake 3.13 (the default with CentOS7)  
can't read the dependence as it was intro - so after the first failure you need to edit CMakeLists.txt 
to require 3.15

```
cd yandasoft
git clone https://github.com/casacore/casacore
cd casacore/python 
vim CMakeLists.txt
```

The line should look like this
```
 (${CMAKE_MAJOR_VERSION} EQUAL 3 AND ${CMAKE_MINOR_VERSION} GREATER 15))
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


```
module load mpi/openmpi-x86_64
```