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

### Remove openmpi 

```
vim build_all.sh
```

### Build
```
module load openmpi/3.1.4

sudo ./build_all.sh -s centos -p /fsx/yandasoft -S -c -a -r -y -j X -Y "-D CMAKE_PREFIX_PATH=/opt/amazon/efa"
```

### Copy the measures 

```
wget ftp://ftp.astron.nl/outgoing/Measures/WSRT_Measures.ztar
sudo mkdir -p /fsx/yandasoft/share/casacore/data
sudo tar -xvf WSRT_Measures.ztar -C /fsx/yandasoft/share/casacore/data
rm WSRT_Measures.zta
```

### Copy from Lustre -> S3

```
nohup find yandasoft/ -type f -print0 | xargs -0 -n 1 sudo lfs hsm_archive &
```
