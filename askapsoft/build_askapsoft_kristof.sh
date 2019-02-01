#	This script is the collection of commands
#	notes, advices and patches
#	to build ASKAPSoft version: CP-0.19
#	on Ubuntu 18.04
#
#	Also installation of DALiuGE v.0.5.0
#	and Jacal vit latest commit 5a67eb0  
#
#	The script is going to produce an error if run
#	as this is just a guide of installation!
#
#	For python I use the Anaconda enviroment
#	And the update.sh is only three commands:
#	sudo apt-get update;
#	sudo apt-get upgrade;
#	sudo apt-get dist-upgrade
#
#Author: Rozgonyi Kristof
#Date  : 2018
#License: MIT
#============================================

#=== ASKAPSoft source ===
#https://bitbucket.csiro.au/projects/CASSSOFT/repos/askapsoft/browse?at=refs%2Ftags%2FCP-0.19.0

#=======================================
#=======================================
#=== STEP-BY-STEP INSTALLATION GUIDE ===
#=======================================
#=======================================
#
#	Based on the installation guide on bitbucket
#	(source) the following packages need to be
#	installed on a standard Ubuntu Bionic Beaver:
#

#=== Install software requirements ===

#There is no need to install java 1.7!
#===
#openjdk-7-jdk
#	This is tricky because Java 1.7
#	available only from Oracle to do manual installation
#	Download from Oracle or from some random site
#
#	Installation based on this:
#	https://tutorialforlinux.com/2018/02/22/how-to-install-oracle-jdk-7-on-ubuntu-18-04-bionic-lts/
#
#wget http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-7u80-linux-x64.tar.gz
#tar xvzf jdk-7*.tar.gz -C /tmp/
#sudo mv /tmp/jdk1.7* /usr/lib/jvm/
#sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.7*/bin/java 1065
#sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.7*/bin/javac 1065
#sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.7*/bin/jar 1065
#sudo update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/jdk1.7*/bin/javaws 1065
##Check java versions and update priority list (no need to set 1.7 as default)
#update-alternatives --config java
#===

#python-dev
sudo apt-get install python-dev
#flex
sudo apt-get install flex
#bison
sudo apt-get install bison
#openmpi-bin
sudo apt-get install openmpi-bin
#libopenmpi-dev
sudo apt-get install libopenmpi-dev
#libfreetype6-dev
sudo apt-get install libfreetype6-dev

#libpng12-dev
#	The package libpng12-dev was dropped after 16.04.
#	We have libpng-dev instead which is installed by default
#	If it is not working then install the package manually:
#	https://packages.ubuntu.com/xenial/amd64/libpng12-0/download
#	However for me it seem sworking, so no worries.

#=== Things that specific to Ubuntu ===
#autoconf
sudo apt-get install autoconf
#pkg-config
sudo apt-get install pkg-config
#scons
sudo apt-get install scons
#ant
sudo apt-get install ant
#ant-optional
sudo apt-get install ant-optional
#libatlas-base-dev
sudo apt-get install libatlas-base-dev

#setuptools (!)
#	setuptools is outdated by default,
#	I couldn't find a solution for that,
#	So if setuptools outdated error comes up
#	just build ASKAPSoft partialy
#	(withouth matplotlib) from a subdirectory
cd ~/askapsoft/Code/Systems/rialto
rbuild -S -a -v
#	Some functions will not work this way
#	Because it is a matplotlib-related problem,
#	plotting stuff will not work inside ASKAPSoft

#===========================
#=== Installation itself ===
#===========================
#=== Clone ASKAPSoft ===
git clone https://bitbucket.csiro.au/scm/casssoft/askapsoft.git

#=== Checkout & Bootstrap ===
#	The command $ svn co https://svn.atnf.csiro.au/askapsdp/trunk ASKAPsoft
#	requires password so I just skip it
cd askapsoft/
/usr/bin/python2.7 bootstrap.py -n

#=== Building ===
. initaskap.sh
rbuild -S -a -v


#=== Possible problems while building ===

#Here are some example all could be solved by create patches

#ERROR: numpy/core/src/multiarray/numpyos.c:18:10: fatal error: xlocale.h: No such file or directory
#
#Solution:
#	This is because xlocale.h was removed in glibc 2.26
#	Thus a patch is needed to add to askapsoft's numpy:
#	Create the patch:
#

#Create the patch file by copying the output to a patch file:
diff -Naur numpy/core/src/multiarray/numpyos.c.orig numpy/core/src/multiarray/numpyos.c
#Ctrl+Shift+C

#Ctrl+Shift+V
vim patch-no-xlocale.h

#The patch should be look like this:
#=======================
#
#	--- numpy/core/src/multiarray/numpyos.c.orig	2016-06-25 16:59:40.000000000 -0700
#	+++ numpy/core/src/multiarray/numpyos.c	2016-08-30 13:51:30.607025309 -0700
#	@@ -15,7 +15,6 @@
#	 
#	 #ifdef HAVE_STRTOLD_L
#	 #include <stdlib.h>
#	-#include <xlocale.h>
#	 #endif
#
#=======================
#Move the patch to the right place
mv ~/patch-no-xlocale.h ~/askapsoft/3rdParty/numpy/numpy-1.12.0/files/ 

#===
#ERROR: During the build of CASACore there is a type conversion problem
#
#SOLUTION:
#	That is because the C++ compiler version is above 11
#	And CASACore is old (2.0.3 version), thus
#	CASACore having some c++11 compiler specific stuff
#	Fix again with a patch:

cd ~/askapsoft/3rdParty/casacore/casacore-2.0.3/
cp casacore-2.0.3/tables/apps/taql.cc{,.new} 
vim casacore-2.0.3/tables/apps/taql.cc
vim casacore-2.0.3/tables/apps/taql.cc.new 
diff -Naur casacore-2.0.3/tables/apps/taql.cc{,.new} 

#The patch will look like:
#
#	--- casacore-2.0.3/tables/apps/taql.cc	2015-07-24 15:01:01.000000000 +0800
#	+++ casacore-2.0.3/tables/apps/taql.cc.new	2018-05-14 17:00:44.057234624 +0800
#	@@ -77,7 +77,7 @@
#	 {
#	   if (!prompt.empty()) cerr << prompt;
#	   getline (cin, line);
#	-  return cin;
#	+  return cin.good();
#	 }
#	 #endif
#

#Create patch
diff -Naur casacore-2.0.3/tables/apps/taql.cc{,.new}  > files/patch-tables::taql.cc
#Edit the patch
vim files/patch-tables::taql.cc

#New file:
#
#	--- ./tables/apps/taql.cc.orig	2015-07-24 15:01:01.000000000 +0800
#	+++ ./tables/apps/taql.cc	2018-05-14 17:00:44.057234624 +0800
#	@@ -77,7 +77,7 @@
#	 {
#	   if (!prompt.empty()) cerr << prompt;
#	   getline (cin, line);
#	-  return cin;
#	+  return cin.good();
#	 }
#	 #endif
#
#Note that the changes are in the first two lines in the path  and filename!

#Now start the building from the beginning!
rbuild -S -a -v

#===
#ERROR: Java version 10+ is too old
#
#Solution:
#	This is because some stupid script looking for java version 2-9 and
#	10+ is not in the list so it declared as old.
#	Solution is to write a patch again:
#

cd ~/askapsoft/3rdParty/Berkeley-DB/db-5.3.21.NC

cp db-5.3.21.NC/dist/configure{,.orig}
vim db-5.3.21.NC/dist/configure #change the stuff (see patch)
diff db-5.3.21.NC/dist/configure.orig db-5.3.21.NC/dist/configure
diff -Naur db-5.3.21.NC/dist/configure.orig db-5.3.21.NC/dist/configure

#The patch will look like (so this is the difference):
#
#	--- db-5.3.21.NC/dist/configure.orig	2018-05-15 12:09:49.395794446 +0800
#	+++ db-5.3.21.NC/dist/configure	2018-05-15 12:10:39.451866347 +0800
#	@@ -18475,7 +18475,7 @@
#	 	{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $JAVA_VERSION" >&5
#	 $as_echo "$JAVA_VERSION" >&6; }
#	 	case "$JAVA_VERSION" in
#	-	1.[3456789]* | 1.[1-9][0-9]* | [23456789]* ) ;;
#	+	1.[3456789]* | 1.[1-9][0-9]* | [23456789]* | 11 ) ;;
#	 	* )
#	 		as_fn_error $? "Java version 1.3 or higher required, got $JAVA_VERSION" "$LINENO" 5 ;;
#	 	esac
#

diff -Naur db-5.3.21.NC/dist/configure.orig db-5.3.21.NC/dist/configure > files/patch-configure.patch

#Change the route to ./db-5.3.21.NC/...etc ==> change the first two line
vim files/patch-configure.patch 

#Continue building
rbuild -S -a 

#Some magic with build
#The diff you need to make:
#
#	--- a/3rdParty/casacore/casacore-2.0.3/build.py
#	+++ b/3rdParty/casacore/casacore-2.0.3/build.py
#	@@ -47,8 +47,8 @@ else:
#	     lapack  = builder.dep.get_install_path("lapack")
#	     
#	     # CMake doesn't know about ROOT_DIR for these packages, so be explicit
#	-    builder.add_option("-DBLAS_LIBRARIES=%s" % os.path.join(blas, 'lib', 'libblas.a'))
#	-    builder.add_option("-DLAPACK_LIBRARIES=%s" % os.path.join(lapack, 'lib', 'liblapack.a'))
#	+    builder.add_option("-DBLAS_LIBRARIES=%s" % os.path.join(blas, 'lib', 'libblas.so'))
#	+    builder.add_option("-DLAPACK_LIBRARIES=%s" % os.path.join(lapack, 'lib', 'liblapack.so'))
#	     builder.add_option("-DCMAKE_C_COMPILER=gcc")
#	     builder.add_option("-DCMAKE_CXX_COMPILER=g++")
#
#Then need to manually build some stuff, so not with rbuild but with setup.py or with cmake...ect
#I couldn't follow the magic here :(

#Also for Jacal we needed to build things in ~/askapsoft/???/CP/simager/ banually
#Cube packages maybe (?)

#===============
#=== DALiuGE ===
#===============
#Clone DALiuGE
git clone https://github.com/ICRAR/daliuge

#Install native python virtualenv package:
sudo apt install python3-venv

#Create virtual enviroment for DALiuGE using native python
/usr/bin/python3.6 -mvenv dlg_venv

#Activate virtual enviroment
source /home/krozgonyi/dlg_venv/bin/activate

#To install DALiuGE we need some dependiences first in the virtual enviroment
pip install wheel
#We used native python instead of Anaconda
sudo apt install python3-dev

#It is better than executing setup.py, this is pip install using local packages
#+ download the required pre-compiled packages thus don't need to compile locally as mutch
pip install -e .

#=============
#=== JACAL ===
#=============
#clone Jacal:
git clone https://github.com/ICRAR/jacal

#For Jacal installation we have to set up some path to ASKASoft:
#Simple installation:
ASKAP_ROOT=/home/krozgonyi/askapsoft/ make

#Build standalone:
ASKAP_ROOT=/home/krozgonyi/askapsoft/ make standalone
#then:
LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH ./standalone



