require 'open3'

Given(/^I have a running nagios host$/) do
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant reload nagioshost"

  expect(status.success?).to eq(true)
end

Given(/^I provision the nagios host$/) do
  output, _, status = Open3.capture3 "unset RUBYLIB; vagrant provision nagioshost"
  puts output
  expect(status.success?).to eq(true)
end

When(/^I install Nagios Plugins and NRPE$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.nagios_host.yml --tags 'nagios_plugins_install' -vvv"

  output, error, @status = Open3.capture3 "#{cmd}"
  puts output
  puts error
end

Then(/^It should be successful$/) do
  expect(@status.success?).to eq(true)
end
