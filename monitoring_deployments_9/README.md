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

# Deploying to production

### Setup

* Create a file called _secret_vars.yml_, copying the contents of _secret_vars.example.yml_. Replace the values in the file with yours.
* Update the variables in _vars.yml_ file with yours particularly the _key_pair_name_.

### Create EC2 instances

* Run `ansible-playbook playbook.ec2.yml` to create two EC2 instances - One for the server and the other for the host.
* Copy the ip address of the instances and replace the ip addresses in  _prod_inventory.ini_ file with that of your instances where _nagiosserver_ is your server and _nagioshost_ is your host.

### Provision the instances

* Run `ansible-playbook playbook.provision.yml -i prod_inventory.ini` to provision both instances.

### Set up Node in host server

* Run `ansible-playbook playbook.mean.yml -i prod_inventory.ini` to install Mongo and Node on the host server.

### Deploy Node app to host server

* Run `ansible-playbook playbook.node_app.yml -i prod_inventory.ini` to deploy your node app to your host server. Remember to change the `node_app_repo` variable in `vars.yml` to that of the app you want to deploy.
* Visit your application on the `host_ip_address:5000`
