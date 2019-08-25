# Build the DINGO Base

## Create the instances

Start the instance from the CycleCloud console

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
sudo yum -y install lapack-devel.x86_64 lapack.x86_64 python2-numpy xerces-c-devel hdf5-devel cppunit-devel
```

### Build YandaSoft
```
cd ~/yandasoft 

sudo ./build_all.sh -s centos -p /shared -S -c -a -r -y -j 4
```

### Copy the measures 

YandaSoft needs this to work as it holds the leap second data and the like.

```
wget ftp://ftp.astron.nl/outgoing/Measures/WSRT_Measures.ztar
sudo mkdir -p /shared/share/casacore/data
sudo tar -xvf WSRT_Measures.ztar -C /shared/share/casacore/data
rm WSRT_Measures.ztar
```

## Tar Ball

```
tar -xvzf azure-yandasoft.tar.gz /shared/bin /shared/include /shared/lib /shared/man /shared/share
```

# Copying DINGO files

## Setup AWS
```
sudo pip install virtualenv
virtualenv ~/virt-env/aws
source ~/virt-env/aws/bin/activate
pip install awscli
```

## Create AWS files
```
mkdir ~/.aws
vim config
```

```
cd /lustre
aws s3 sync s3://dingo-data-sydney/G12_test G12_test
```

## Clone cloud-dingo
```
cd ~
git clone https://github.com/ICRAR/cloud-dingo.git
```
