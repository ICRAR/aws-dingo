#!/bin/bash

yum -y install \
    boost \
    cfitsio \
    cppunit \
    fftw3 \
    gsl \
    hdf5 \
    lapack.x86_64 \
    libffi \
    log4cxx \
    openblas-devel \
    openssl \
    patch \
    python \
    python-pip \
    python2-numpy \
    readline \
    xerces-c \
    wcslib

# Add the new paths
echo "PATH=/usr/local/bin:/usr/bin:/fsx/yandasoft/bin" >> /etc/environment
echo "LD_LIBRARY_PATH=/fsx/yandasoft/lib" >> /etc/environment

# creates the necessary links and cache to the most recent shared libraries
echo "/fsx/yandasoft/lib" >> /etc/ld.so.conf.d/yandasoft.conf
ldconfig

# Remove the mpich
rm -rf /usr/lib64/mpich

# Add the flock option
sed -i 's/defaults,_netdev/defaults,flock,_netdev/' /etc/fstab
umount /fsx
mount -a

exit 0