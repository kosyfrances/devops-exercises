require 'open3'

Given(/^I have a running server$/) do
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant reload"

  expect(status.success?).to eq(true)
end

Given(/^I provision it$/) do
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant provision"

  expect(status.success?).to eq(true)
end

When(/^I install Apache$/) do
  cmd = "ansible-playbook -i local_inventory.ini --private-key=.vagrant/machines/nagiosserver/virtualbox/private_key -u vagrant playbook.nagios.yml --tags 'apache_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

Then(/^it should be successful$/) do
  expect(@status.success?).to eq(true)
end

And(/^([^"]*) should be running$/) do |pkg|
    case pkg
    when 'apache2', 'mysql', 'xinetd'
      output, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh -c 'sudo service #{pkg} status'"
      expect(status.success?).to eq(true)

      if pkg == 'apache2'
        expect(output).to match("#{pkg} is running")
      else
        expect(output).to match("#{pkg} start/running")
      end

    else
        raise 'Not Implemented'
    end
end

And(/^it should be accepting connections on port (\d+)$/) do |port|
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh -c 'curl -f http://localhost:#{port}'"

  expect(status.success?).to eq(true)
end

When(/^I install MySQL$/) do
  cmd = "ansible-playbook -i local_inventory.ini --private-key=.vagrant/machines/nagiosserver/virtualbox/private_key -u vagrant playbook.nagios.yml --tags 'mysql_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I install PHP$/) do
  cmd = "ansible-playbook -i local_inventory.ini --private-key=.vagrant/machines/nagiosserver/virtualbox/private_key -u vagrant playbook.nagios.yml --tags 'php_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I create user and group$/) do
  cmd = "ansible-playbook -i local_inventory.ini --private-key=.vagrant/machines/nagiosserver/virtualbox/private_key -u vagrant playbook.nagios.yml --tags 'nagios_user_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

And(/^user should exist$/) do
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh -c 'getent passwd nagios'"

  expect(status.success?).to eq(true)
end

When(/^I install build dependencies$/) do
  cmd = "ansible-playbook -i local_inventory.ini --private-key=.vagrant/machines/nagiosserver/virtualbox/private_key -u vagrant playbook.nagios.yml --tags 'build_dependencies'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I install Nagios core$/) do
  cmd = "ansible-playbook -i local_inventory.ini --private-key=.vagrant/machines/nagiosserver/virtualbox/private_key -u vagrant playbook.nagios.yml --tags 'nagios_core_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I add wwwdata user to nagios group$/) do
  cmd = "ansible-playbook -i local_inventory.ini --private-key=.vagrant/machines/nagiosserver/virtualbox/private_key -u vagrant playbook.nagios.yml --tags 'add_wwwdata_nagios'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I install Nagios plugins$/) do
  cmd = "ansible-playbook -i local_inventory.ini --private-key=.vagrant/machines/nagiosserver/virtualbox/private_key -u vagrant playbook.nagios.yml --tags 'nagios_plugins_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I install NRPE$/) do
  cmd = "ansible-playbook -i local_inventory.ini --private-key=.vagrant/machines/nagiosserver/virtualbox/private_key -u vagrant playbook.nagios.yml --tags 'nrpe_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

Then(/^xinetd startup script should be updated$/) do
  cmd = "ansible-playbook -i local_inventory.ini --private-key=.vagrant/machines/nagiosserver/virtualbox/private_key -u vagrant playbook.nagios.yml --tags 'xinetd_script_setup' -vvv"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I edit Nagios configuration$/) do
  cmd = "ansible-playbook -i local_inventory.ini --private-key=.vagrant/machines/nagiosserver/virtualbox/private_key -u vagrant playbook.nagios.yml --tags 'nagios_configure' -vvv"

  _, _, @status = Open3.capture3 "#{cmd}"
end

And(/^a server configuration directory should exist$/) do
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh -c 'test -d /usr/local/nagios/etc/servers'"

  expect(status.success?).to eq(true)
end
