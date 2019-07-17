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
    openblas \
    openmpi3 \
    openssl \
    patch \
    python \
    python-pip \
    python2-numpy \
    readline \
    xerces-c \
    wcslib

echo "PATH=/usr/local/bin:/usr/bin:/fsx/yandasoft/bin" >> /etc/environment
echo "LD_LIBRARY_PATH=/fsx/yandasoft/lib" >> /etc/environment

# Add the new paths
echo "PATH=/usr/local/bin:/usr/bin:/fsx/yandasoft/bin" >> /etc/environment
echo "LD_LIBRARY_PATH=/fsx/yandasoft/lib" >> /etc/environment

# Remove the mpich
rm -rf /usr/lib64/mpich

exit 0