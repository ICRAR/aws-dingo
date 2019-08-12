#!/bin/bash

yum -y install \
    bison \
    boost-devel \
    cmake3 \
    cppunit-devel \
    fftw3-devel \
    flex \
    gcc-c++ \
    git \
    gsl-devel \
    hdf5-devel \
    htop \
    lapack-devel.x86_64 \
    lapack.x86_64 \
    libffi-devel \
    log4cxx-devel \
    make \
    openblas-devel \
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
echo "PATH=/usr/local/bin:/usr/bin:/dingo/yandasoft/bin" >> /etc/environment
echo "LD_LIBRARY_PATH=/dingo/yandasoft/lib" >> /etc/environment

# creates the necessary links and cache to the most recent shared libraries
echo "/dingo/yandasoft/lib" >> /etc/ld.so.conf.d/yandasoft.conf
ldconfig

# Remove the mpich
rm -rf /usr/lib64/mpich

# Add the flock option
#sed -i 's/defaults,_netdev/defaults,flock,_netdev/' /etc/fstab
#umount /fsx
#mount -a

#chmod oug+rwx -R /dingo

exit 0
