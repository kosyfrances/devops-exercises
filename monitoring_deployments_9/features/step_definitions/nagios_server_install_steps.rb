require 'open3'

Given(/^I have a running server ([^"]*)$/) do |server|
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant reload #{server}"

  expect(status.success?).to eq(true)
end

Given(/^I provision it ([^"]*)$/) do |server|
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant provision #{server}"

  expect(status.success?).to eq(true)
end

When(/^I install Apache$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'apache_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

Then(/^it should be successful$/) do
  expect(@status.success?).to eq(true)
end

And(/^([^"]*) should be running on ([^"]*)$/) do |pkg, server|
    case pkg
    when 'apache2', 'mysql', 'xinetd', 'nagios', 'nagios-nrpe-server'
      output, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh #{server} -c 'sudo service #{pkg} status'"
      expect(status.success?).to eq(true)

      if ['apache2', 'nagios'].include? pkg
        expect(output.chomp).to match(Regexp.new("#{pkg}\s(\\(\\w+\s\\d+\\)\s)?is\srunning(\.+)?"))
      elsif pkg == 'nagios-nrpe-server'
        expect(output).to match("nagios-nrpe is running")
      else
        expect(output).to match("#{pkg} start/running")
      end

    else
        raise 'Not Implemented'
    end
end

And(/^it should be accepting connections on port (\d+)$/) do |port|
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh nagiosserver -c 'curl -f http://localhost:#{port}'"

  expect(status.success?).to eq(true)
end

When(/^I install MySQL$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'mysql_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I install PHP$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'php_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I create user and group$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'nagios_user_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

And(/^user should exist$/) do
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh nagiosserver -c 'getent passwd nagios'"

  expect(status.success?).to eq(true)
end

When(/^I install build dependencies$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'build_dependencies'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I install Nagios core$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'nagios_core_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I add wwwdata user to nagios group$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'add_wwwdata_nagios'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I install Nagios plugins$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'nagios_plugins_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I install NRPE$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'nrpe_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

Then(/^xinetd startup script should be updated$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'xinetd_script_setup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I edit Nagios configuration$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'nagios_configure'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

And(/^a server configuration directory should exist$/) do
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh nagiosserver -c 'test -d /usr/local/nagios/etc/servers'"

  expect(status.success?).to eq(true)
end

When(/^I configure nagios contacts$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'nagios_contacts_configure'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I configure check_nrpe command$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'check_nrpe_configure'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I configure apache$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'apache_configure'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I add host to nagios configuration$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_server.yml --tags 'add_host_to_nagios'"

  _, _, @status = Open3.capture3 "#{cmd}"
end
