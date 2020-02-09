#!/bin/sh

### DB boot file

set -x

sudo cp db-hosts /etc/hosts 

rm -f /home/ubuntu/.ssh/id_rsa

ssh-keygen -f /home/ubuntu/.ssh/id_rsa -q -N ""

cat ~/.ssh/*.pub >> ~/.ssh/authorized_keys


ssh-keyscan -H localhost >> ~/.ssh/known_hosts


sudo apt-get install ansible -y

cd ~

echo "localhost" > hosts


##sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
##sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'

echo "mysql-server mysql-server/root_password password password" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password password" | sudo debconf-set-selections


sudo cp hosts /etc/ansible/hosts

sudo apt-get update -y

ansible-playbook db-wp.yaml -v

sudo service mysql stop

cd /var/lib

sudo rm -rf mysql 


sudo git clone https://github.com/pirillion/mysql.git

sudo chown -R mysql:mysql mysql

sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf

sudo service mysql restart
