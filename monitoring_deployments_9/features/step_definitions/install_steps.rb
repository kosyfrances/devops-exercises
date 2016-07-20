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

And(/^apache should be running$/) do
  output, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh -c 'sudo service apache2 status'"

  expect(status.success?).to eq(true)
  expect(output).to match("apache2 is running")
end

And(/^it should be accepting connections on port (\d+)$/) do |port|
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh -c 'curl -f http://localhost:#{port}'"

  expect(status.success?).to eq(true)
end
