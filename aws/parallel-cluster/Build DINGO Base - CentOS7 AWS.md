# Build the DINGO Base

## Start ParallelCluster

```
pcluster create small-test


```


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
sudo yum -y install lapack-devel.x86_64 lapack.x86_64 python2-numpy xerces-c-devel hdf5-devel cppunit-devel
```



```
module load mpi/mpich-x86_64
```


```
cd ~/yandasoft 

vim ./build_all.sh

sudo ./build_all.sh -s centos -p /fsx/bin -S -c -a -r -y -e -j X
```

## Modify /etc/environment

``` 
PATH=/usr/local/bin:/usr/bin:/fsx/bin
```
