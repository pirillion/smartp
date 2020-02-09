#!/bin/sh

### boot build script 

set -x

terraform apply -auto-approve

## get ips
privwebip=`terraform state show aws_eip.web | grep -i private_ip | awk -F= '{print $2}' | awk -F\" '{print $2}' `
pubwebip=`terraform state show aws_eip.web | grep  "public_ip" | grep -v ipv4 | awk -F= '{print $2}'  | awk -F\" '{print $2}' `

privdbip=`terraform state show aws_eip.db | grep -i private_ip | awk -F= '{print $2}' | awk -F\" '{print $2}' `
pubdbip=`terraform state show aws_eip.db | grep -i public_ip | grep -v ipv4 | awk -F= '{print $2}'  | awk -F\" '{print $2}' ` 

rm -f web-hosts
rm -f db-hosts
cp blankhosts web-hosts 
cp blankhosts db-hosts 
echo "$privdbip database" >> web-hosts
echo "$privwebip wp-server" >> db-hosts

scp -i ./mykey web-bootstrap.sh ubuntu@$pubwebip:/home/ubuntu/
scp -i ./mykey web-wp.yaml ubuntu@$pubwebip:/home/ubuntu/
scp -i ./mykey hosts ubuntu@$pubwebip:/home/ubuntu/
scp -i ./mykey web-hosts ubuntu@$pubwebip:/home/ubuntu/


scp -i ./mykey db-bootstrap.sh ubuntu@$pubdbip:/home/ubuntu/
scp -i ./mykey db-wp.yaml ubuntu@$pubdbip:/home/ubuntu/
scp -i ./mykey hosts ubuntu@$pubdbip:/home/ubuntu/
scp -i ./mykey db-hosts ubuntu@$pubdbip:/home/ubuntu/


ssh -i ./mykey ubuntu@$pubwebip ./web-bootstrap.sh
ssh -i ./mykey ubuntu@$pubdbip ./db-bootstrap.sh
