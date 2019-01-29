# Docker Notes

### Build

```bash
docker build -t askapsoft-mpi .
```

### Running ASKAP Soft

```bash
docker run -d -it --name devtest --mount type=bind,source="$(pwd)",target=/app askapsoft-mpi

docker exec -it devtest mpirun --allow-run-as-root cimager -c /app/science_spectral_imager_F00_B00_3260458.uvav.in
```

_Docker hates you running thinks as root, which is why you need **--allow-run-as-root**_

### Logging into Docker Container

```bash
docker exec -it devtest /bin/bash
```