
# Copy files from local machine

```bash
scp -i "~/.ssh/aws-chiles02-sydney.pem" -r data ubuntu@ec2-54-206-20-190.ap-southeast-2.compute.amazonaws.com:/home/ubuntu/aws-dingo
```

# Setup Docker
```bash
cd ~/aws-dingo/docker
docker build .
```

# Run docker
```bash
sudo docker run -d -it --name functest --mount type=bind,source="$(pwd)",target=/app --mount type=bind,source=/home/ubuntu/aws-dingo/geodetic,target=/usr/local/geodetic askapsoft-mpi


sudo docker exec -it functest mpirun --allow-run-as-root cimager -c /app/science_spectral_imager_F00_B00_3260458.uvav.in
```
