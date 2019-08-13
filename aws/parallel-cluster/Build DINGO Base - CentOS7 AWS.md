# Build the DINGO Cluster

[ParallelCluster](https://docs.aws.amazon.com/parallelcluster/) works with Centos7 or Ubuntu16.
Unfortunately Yandasoft seems to require Ubuntu 18 so I couldn't build it.

The cluster works by using [FSx](https://aws.amazon.com/fsx/lustre/getting-started/) as the Lustre file system which is shared by the compute nodes.
The compute nodes will be started and stop depending on the compute demand.

**You are paying for the [FSx](https://aws.amazon.com/fsx/lustre/pricing/) whilst the Lustre file system exists and for TB of data it can quickly become a large bill.**

At the time of writing, Parallel cluster doesn't use the ```~/.aws/credentials``` you have to have the AWS keys in the ```~/.aws/config``` file. 


# ParallelCluster boot scripts

A quote from the AWS website: 

> The AWS ParallelCluster team highly recommends using the scripts in Custom Bootstrap Actions for customization, because post-install hooks are generally easier to debug and more portable across releases of AWS ParallelCluster.

So I used two scripts to load the libraries when [building](s3_post_install_build.sh) and when [running](s3_post_install_run.sh).

These scripts do the following:
* Load the libraries required for building/running.
* Setup PATH and LD_LIBRARY_PATH environment variables to point to the lustre file system ```/dingo/yandasoft```.
* Remove ```mpich``` from the system.
* Edit ```/etc/fstab``` so the lustre mount has _flock_ added to it. This is needed by YandaSoft.
* Remount the filesystems. 

# Building YandaSoft onto Lustre 

You should only need this once. 
Once Yandasoft is built onto FSx and archived to S3 - you shouldn't need to do it again.

Modify the [config file](min-config.ini) to have the following.

```
[global]
cluster_template = build
```

This makes the head node a decent size compute node so the build process doesn't take too long.

## Create the cluster
```
pcluster create small-test
```

**WAIT - this can take quite a long time...**

## Clone YANDASOFT

```
cd ~
git clone https://bitbucket.csiro.au/scm/askapsdp/yandasoft.git

cd yandasoft 
```

### Remove openmpi 

The ParallelCluster nodes come with there own version of openmpi install.
This has a lot of code to improve the speed of the network fabric used by the cluster.
This means we need to stop Yandasoft's build process from loading the libraries.
In fact all the libraries required should have been loaded by the post-boot script.

```
vim build_all.sh

Remove the openmpi-devel line
```

### Build

Amazon's implementation of openmpi is not in the usual place. 
So you need to tell CMake where to find it.

```
module load openmpi/3.1.4
```

#### CFITSIO
```
cd
wget http://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio_latest.tar.gz
tar -xvf cfitsio_latest.tar.gz
cd cfitsio-3.47/
./configure --prefix=/dingo/yandasoft --enable-reentrant
make
sudo make install
``` 

#### YANDASOFT 
```
sudo ./build_all.sh -s centos -p /dingo/yandasoft -S -c -a -r -y -j 4
```

### Copy the measures 

YandaSoft needs this to work as it holds the leap second data and the like.

```
wget ftp://ftp.astron.nl/outgoing/Measures/WSRT_Measures.ztar
sudo mkdir -p /dingo/yandasoft/share/casacore/data
sudo tar -xvf WSRT_Measures.ztar -C /dingo/yandasoft/share/casacore/data
rm WSRT_Measures.zta
```

### Copy from Lustre -> S3

```
nohup find yandasoft/ -type f -print0 | xargs -0 -n 1 sudo lfs hsm_archive &
```
