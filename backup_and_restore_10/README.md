# Outcome 10 - Backup & Restore

An exercise that covers the following operations:
  - Setting up recurring automatic backups of critical data (database, e.t.c) on a system
  - Setting up scripts to verify the backups to ensure it is valid and restorable
  - Setting up scripts to move the backup data to an external store (AWS S3)
  - Putting together a recovery plan to restore the data in the event of data loss

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
* Update the variables in _vars.yml_ file with yours.
* Update _prod_inventory.ini_ file with your server name and its ip address. Replace `ansible_ssh_private_key_file` with the path to your aws private key file.

### Provision the instances
* Run `ansible-playbook playbook.provision.yml -i prod_inventory.ini` to provision your server.

### Run backup script
* Run `ansible-playbook playbook.backup.yml -i prod_inventory.ini` to set up automatic backup for mysql database to.

# Testing locally

### Setup
* Run `vagrant up`. This will bring up a virtual machine and also provision it.
* Create a file called _secret_vars.yml_, copying the contents of _secret_vars.example.yml_. Replace the values in the file with yours.
* Update the variables in _vars.yml_ file with yours. Note that _host_user_ should be changed to `vagrant` and not `ubuntu` for testing locally.

### Run tests
* Run cucumber features/backup.feature to run tests and set up the virtual machine.
