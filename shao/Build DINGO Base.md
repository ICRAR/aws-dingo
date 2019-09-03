# Shanghi Observatory Build

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

## BBCP

Download the source

```
wget http://www.slac.stanford.edu/~abh/bbcp/bbcp.tgz
tar -zxvf bbcp.tgz
```

Add the ARM target to the Makefile
cd bbcp/src
vim Makefile
```
makeLinuxaarch64:
	@make $(MKPARMS) RR=$(RELNUM) \
	CC=$(LNXCC) \
	BB=$(LNXcc) \
	CFLAGS="$(ENVCFLAGS) $(LNXOPT)" \
	BFLAGS="$(ENVCFLAGS) $(LNXOPT_B)" \
	INCLUDE="$(ENVINCLUDE)" \
	LIBS="$(LNXLIBS64)"
```

Run Make

```
make Linux
```

## Cloud Dingo

```
cd /o9000/ASKAP
git clone https://github.com/ICRAR/cloud-dingo.git

git clone https://bitbucket.csiro.au/scm/askapsdp/yandasoft.git

ln -s /o9000/ASKAP/cloud-dingo/shao/shao_build_all_no_sudo.sh yandasoft/shao_build_all_no_sudo.sh
```

### Build YandaSoft
```
cd yandasoft

./shao_build_all_no_sudo.sh -s centos -p /home/kvinsen/askapsoft -L -C -a -R -y -j 40
```

### Copy the measures 

YandaSoft needs this to work as it holds the leap second data and the like.

```
cd /o9000/ASKAP

wget ftp://ftp.astron.nl/outgoing/Measures/WSRT_Measures.ztar
sudo mkdir -p /o9000/ASKAP/share/casacore/data
sudo tar -xvf WSRT_Measures.ztar -C /o9000/ASKAP/share/casacore/data
rm WSRT_Measures.ztar
```

