#!/bin/bash

component="$1"
dnf install ansible -y
# ansible-pull -U https://github.com/Manibhargavibendalam/ansible-roboshop-roles-tf.git -e component="$component" main.yaml
# git clone ansible-playbook
# cd ansible-playbook
# ansible-playbook -i inventory main.yaml

REPO_URL = https://github.com/Manibhargavibendalam/ansible-roboshop-roles-tf.git
