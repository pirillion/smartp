The provider.tf file needs to contain the AWS access and secret key. These have been removed. Also the private
and public keys mykey and mykey.pub have also been left blank.

The template creates a load balancer, application, and backend mysql DB server. Terraform creates the 
infrastructure. Ansible then installs the required packages on each server.

The bootscript.sh starts the whole process from the base directory smartp. The bootscript.sh has been
tested, and worked before credentials and keys were removed.

