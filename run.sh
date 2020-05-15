#!/bin/sh
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -vv -i hosts.yml --extra-vars "@config.yml" setup.yml -u pi -k -K
