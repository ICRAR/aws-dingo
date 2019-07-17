# Build the DINGO Base

# Building YandaSoft

Modify the config file to have the following

```
[global]
cluster_template = build

```

## Create the cluster
```
pcluster create small-test
```

### WAIT - this takes time...


## Clone YANDASOFT

```
cd ~
git clone https://bitbucket.csiro.au/scm/askapsdp/yandasoft.git

cd yandasoft 
```

### Change openmpi 

Change openmpi to openmpi3

```
vim build_all.sh
```

### Build
```
module load mpi/openmpi3-x86_64

sudo ./build_all.sh -s centos -p /fsx/yandasoft -S -c -a -r -y -j X
```
