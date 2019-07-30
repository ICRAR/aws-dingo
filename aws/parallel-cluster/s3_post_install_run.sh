#!/bin/bash

yum -y install \
    boost \
    cfitsio \
    cppunit \
    fftw3 \
    gsl \
    hdf5 \
    htop \
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
echo "PATH=/usr/local/bin:/usr/bin:/dingo/yandasoft/bin" >> /etc/environment
echo "LD_LIBRARY_PATH=/dingo/yandasoft/lib" >> /etc/environment

# creates the necessary links and cache to the most recent shared libraries
echo "/dingo/yandasoft/lib" >> /etc/ld.so.conf.d/yandasoft.conf
ldconfig

echo "measures.DE200.directory: /dingo/yandasoft/share/casacore/data/ephemerides" >> /home/centos/.casarc
echo "measures.DE405.directory: /dingo/yandasoft/share/casacore/data/ephemerides" >> /home/centos/.casarc
echo "measures.line.directory: /dingo/yandasoft/share/casacore/data/ephemerides" >> /home/centos/.casarc
echo "measures.sources.directory: /dingo/yandasoft/share/casacore/data/ephemerides" >> /home/centos/.casarc
echo "measures.comet.directory: /dingo/yandasoft/share/casacore/data/ephemerides" >> /home/centos/.casarc
echo "measures.ierseop97.directory: /dingo/yandasoft/share/casacore/data/geodetic" >> /home/centos/.casarc
echo "measures.ierspredict.directory: /dingo/yandasoft/share/casacore/data/geodetic" >> /home/centos/.casarc
echo "measures.tai_utc.directory: /dingo/yandasoft/share/casacore/data/geodetic" >> /home/centos/.casarc
echo "measures.igrf.directory: /dingo/yandasoft/share/casacore/data/geodetic" >> /home/centos/.casarc
echo "measures.observatory.directory: /dingo/yandasoft/share/casacore/data/geodetic" >> /home/centos/.casarc

chown centos:centos /home/centos/.casarc

# Remove the mpich
rm -rf /usr/lib64/mpich

# Add the flock option
#sed -i 's/defaults,_netdev/defaults,flock,_netdev/' /etc/fstab
#umount /fsx
#mount -a

#chmod oug+rwx -R /dingo

exit 0
