require 'open3'

When(/^I install Nagios Plugins and NRPE$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_host.yml --tags 'nagios_plugins_install'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

Then(/^It should be successful$/) do
  expect(@status.success?).to eq(true)
end

When(/^I configure allowed hosts and allowed NRPE commands$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_host.yml --tags 'allowed_host_configure'"

  _, _, @status = Open3.capture3 "#{cmd}"
end
