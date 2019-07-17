# Building MPI Tests

## First clone 

```
cd /fsx
git clone https://github.com/ICRAR/cloud-dingo.git
```

## Pulls 

```
cd /fsx/cloud-dingo
git pull
```

## Build 

```
module load mpi/openmpi3-x86_64

cd /fsx/cloud-dingo/aws/parallel-cluster
mpicc hello.c -o hello.mpi
```