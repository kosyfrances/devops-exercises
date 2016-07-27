# Outcome 09 - Monitoring Deployments

Outputs
-------

1. An exercise that covers the following operations:
  - Setting up server monitoring for a _production_ environment using Nagios
  - Analyzing the collected metrics for 5 days and write a comprehensive report with recommendations
2. An exercise that covers the following operations:
  - Setting up application monitoring for a NodeJS application using New Relic
  - Deploying the NodeJS application to a VM on AWS
  - Setting up monitoring for the VM using AWS Cloudwatch


### System Requirements
* Python
* Pip
* Ansible > 2.0
* AWS CLI
* Boto
* Ruby
* Cucumber
* Virtual box (to test locally)

# Deploying to production

### Setup
* Create a file called _secret_vars.yml_, copying the contents of _secret_vars.example.yml_. Replace the values in the file with yours.
* Update the variables in _vars.yml_ file with yours particularly the _key_pair_name_. Change _port_ to the port number your node app will run on, and _node_app_repo_ to the link to your application repository on github.

### Create EC2 instances
* Run `ansible-playbook playbook.ec2.yml` to create two EC2 instances - One for the server and the other for the host.
* Copy the ip address of the instances and replace the ip addresses in  _prod_inventory.ini_ file with that of your instances where _nagiosserver_ is your server and _nagioshost_ is your host. Replace `ansible_ssh_private_key_file` with the path to your aws private key file. Update the ip addresses in your _secret_vars.yml_ also.

* * [optional] You can run `cucumber features/cloudformation_setup.feature` to verify that the cloudformation stack successfully created your EC2 instances.

### Provision the instances
* Run `ansible-playbook playbook.provision.yml -i prod_inventory.ini` to provision both instances.

### Set up Node in host server
* Run `ansible-playbook playbook.mean.yml -i prod_inventory.ini` to install Mongo and Node on the host server.

### Deploy Node app to host server
* Run `ansible-playbook playbook.node_app.yml -i prod_inventory.ini` to deploy your node app to your host server.
* Visit your application on `host_ip_address:5000`

### Configure host server to be monitored by Nagios
* Run `ansible-playbook playbook.nagios_host.yml -i prod_inventory.ini` to configure your host server to be monitored by Nagios.

### Configure Nagios server to monitor host server
* Run `ansible-playbook playbook.nagios_server.yml -i prod_inventory.ini` to configure nagios to monitor the host server.
* Visit Nagios server on `server_ip_address/nagios`, authenticating with `nagiosadmin` as username and your `nagiosadmin_user_password` in _secret_vars.yml_ file.


# Testing locally

### Setup
* Run `vagrant up`. This will bring up two virtual machines - named nagiosserver and nagioshost and also provision them.
* Create a file called _secret_vars.yml_, copying the contents of _secret_vars.example.yml_. Replace the values in the file with yours taking note of the _server_ip_ and _host_ip_ which should be that of the virtual machines created.
* Update the variables in _vars.yml_ file with yours. Change _port_ to the port number your node app will run on and _node_app_repo_ to the link to your application repository on github. Note that _host_user_ should be changed to `vagrant` and not `ubuntu` for testing locally.

### Set up nagios host
* Run `cucumber nagios_host_install.feature` to set up the host for nagios monitoring.

### Set up nagios server
* Run `cucumber nagios_server_install.feature` to set up the server to monitor the host.
 * Visit Nagios server on `server_ip_address/nagios`, authenticating with `nagiosadmin` as username and your `nagiosadmin_user_password` in _secret_vars.yml_ file.
