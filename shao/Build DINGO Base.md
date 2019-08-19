# Shanghi Obeservatory Build

## OS

```
$ cat /etc/*-release

CentOS Linux release 7.6.1810 (AltArch) 
NAME="CentOS Linux"
VERSION="7 (AltArch)"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="7"
PRETTY_NAME="CentOS Linux 7 (AltArch)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:7"
HOME_URL="https://www.centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"

CENTOS_MANTISBT_PROJECT="CentOS-7"
CENTOS_MANTISBT_PROJECT_VERSION="7"
REDHAT_SUPPORT_PRODUCT="centos"
REDHAT_SUPPORT_PRODUCT_VERSION="7"

CentOS Linux release 7.6.1810 (AltArch) 
CentOS Linux release 7.6.1810 (AltArch) 

```

## Preinstall packages we need

```
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
    openmpi-devel \
    openssl-devel \
    patch \
    python-devel \
    python-pip \
    python2-numpy \
    readline-devel \
    svn \
    xerces-c-devel \
    wcslib-devel
```

## Clone YANDASOFT

```
cd ~
git clone https://bitbucket.csiro.au/scm/askapsdp/yandasoft.git

cd yandasoft 
```

