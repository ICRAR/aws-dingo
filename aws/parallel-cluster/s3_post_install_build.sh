#!/bin/bash

yum -y install \
    bison \
    boost-devel \
    cfitsio-devel \
    cmake3 \
    cppunit-devel \
    fftw3-devel \
    flex \
    gcc-c++ \
    git \
    gsl-devel \
    hdf5-devel \
    lapack-devel.x86_64 \
    lapack.x86_64 \
    libffi-devel \
    log4cxx-devel \
    make \
    openblas-devel \
    openmpi3-devel \
    openssl-devel \
    patch \
    python-devel \
    python-pip \
    python2-numpy \
    readline-devel \
    svn \
    xerces-c-devel \
    wcslib-devel

# Add the new paths
echo "PATH=/usr/local/bin:/usr/bin:/fsx/yandasoft/bin" >> /etc/environment
echo "LD_LIBRARY_PATH=/fsx/yandasoft/lib" >> /etc/environment

# Remove the mpich
rm -rf /usr/lib64/mpich

exit 0