#!/bin/bash

dnf install ansible -y
ansible-pull -u https://github.com/Manibhargavibendalam/ansible-roboshop-roles-tf.git -e component=mongodb main.yaml