#!/bin/bash -xv
cd /home/ubuntu/aws-dingo
sudo -H  -u ubuntu bash -c "git pull"
bash /home/ubuntu/aws-dingo/cloudformation/create_ephemeral_disks.sh
