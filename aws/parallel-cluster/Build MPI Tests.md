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
module load openmpi/3.1.4

cd /fsx/cloud-dingo/aws/parallel-cluster
mpicc hello.c -o hello.mpi
```