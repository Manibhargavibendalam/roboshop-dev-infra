#!/bin/bash

#growing the /home volume for the terraform purpose
growpart /dev/nvme0n1 4
lvextend -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

# lvreduce -r -L 50G /dev/mapper/RootVG-homeVol  to take volume back

#creating databases
cd /home/ec2-user
git clone https://github.com/Manibhargavibendalam/roboshop-dev-infra.git
chown ec2-user:ec2-user -R roboshop-dev-infra
terraform init
terraform apply -auto-approve
