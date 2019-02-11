# Docker Notes

### Build

```bash
docker build -t askapsoft-mpi .
```

### Running ASKAP Soft

```bash

docker run -d -it --name dingo --mount type=bind,source="$(pwd)",target=/app --mount type=bind,source=/mnt/dingo,target=/mnt/dingo --mount type=bind,source=/home/ubuntu/aws-dingo/geodetic,target=/usr/local/geodetic askapsoft-mpi

docker exec -it dingo mpirun --allow-run-as-root -np 1 cimager -c /app/science_spectral_imager_F00_B00_4053943.in
```

_Docker hates you running thinks as root, which is why you need **--allow-run-as-root**_

### Logging into Docker Container

```bash
docker exec -it devtest /bin/bash
```

### Stopping all docker containers
```bash
docker stop $(docker ps -aq)
```

```bash
docker rm $(docker ps -aq)
```

```bash
docker rmi $(docker images -q)
```
