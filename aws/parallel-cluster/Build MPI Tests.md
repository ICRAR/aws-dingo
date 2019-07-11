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
cd /fs/cloud-dingo/aws/parallel-cluster
mpicc hello.c -o hello.mpi
```