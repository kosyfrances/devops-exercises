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
    when 'apache2', 'mysql'
      output, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh -c 'sudo service #{pkg} status'"
      expect(status.success?).to eq(true)

      if pkg == 'mysql'
        expect(output).to match("#{pkg} start/running")
      else
        expect(output).to match("#{pkg} is running")
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

Then(/^user should exist$/) do
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh -c 'getent passwd nagios'"

  expect(status.success?).to eq(true)
end
