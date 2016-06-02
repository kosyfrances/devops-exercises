# Assessment 03 - Configuration Management

This project sets up a MEAN stack environment using ansible to test knowledge of the  configuration management learning outcome.

### Testing Locally
**Install the following on your mac:**

- VirtualBox: _brew cask install virtualbox_
- Vagrant: _brew cask install vagrant_
- Python: _brew install python_
- Ansible: _pip install ansible_
- Ruby: _brew install rbenv ruby-build_

Note that Ruby and Python are available by default on macs. Be sure to verify that.

If you are using rbenv, do this in the terminal.

```
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile
```
- Install Ruby
```
rbenv install 2.3.0
rbenv global 2.3.0
ruby -v
```

**Clone the project**
```
$ git clone https://github.com/andela-kanyanwu/devops-exercises.git
```

**Set it up**
```
$ cd devops-exercises/config_management_assessment_3/
$ vagrant up
$ vagrant ssh
```

Switch to another terminal in your local machine, not inside your VM, run
```
$ bundle install
$ cucumber features/install.feature
```
This runs all the tests and installs everything using ansible in your virtual machine.
