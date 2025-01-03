#!/bin/bash

component=$1
environment=$2
echo "Component: $component, Environment: $environment"
dnf install ansible -y
ansible-pull -i localhost, -U https://github.com/KalpanaReddyN/expense-ansible-roles-tf.git main.yaml -e component=$component -e environment=$environment


# lets say if i gave com=$1 and env=$2 then i should use in the last lien of code -e component=$com -e environment=$env 