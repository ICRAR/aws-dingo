#!/usr/bin/env bash

# This script should be run from pleiades
rsync --progress -av -e "ssh -i ~/.ssh/aws-chiles02-sydney.pem" {dorado,g23} ubuntu@ec2-AA-BB-CC-DD.ap-southeast-2.compute.amazonaws.com:/home/ubuntu/aws-dingo/data


