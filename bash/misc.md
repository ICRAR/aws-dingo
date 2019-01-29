
# Copy files from local machine

```bash
scp -i "~/.ssh/aws-chiles02-sydney.pem" -r data ubuntu@ec2-54-206-20-190.ap-southeast-2.compute.amazonaws.com:/home/ubuntu/aws-dingo
```

# Setup Docker
```bash
cd ~/aws-dingo/docker
docker build .
```
