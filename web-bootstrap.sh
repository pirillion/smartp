#!/bin/sh

set -x

sudo cp web-hosts /etc/hosts

rm -f /home/ubuntu/.ssh/id_rsa

ssh-keygen -f /home/ubuntu/.ssh/id_rsa -q -N ""


cat ~/.ssh/*.pub >> ~/.ssh/authorized_keys

ssh-keyscan -H localhost >> ~/.ssh/known_hosts

sudo apt-get install ansible -y

cd ~

echo "localhost" > hosts


sudo cp hosts /etc/ansible/hosts

sudo apt-get update -y

ansible-playbook web-wp.yaml -v


cd /var

sudo rm -rf www

sudo git clone https://github.com/pirillion/www.git

sudo chown -R www-data:www-data /var/www/html
