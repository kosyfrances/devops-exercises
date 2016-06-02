require 'open3'

Given(/^I have a running server$/) do
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant reload"

  expect(status.success?).to eq(true)
end

Given(/^I provision it$/) do
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant provision"

  expect(status.success?).to eq(true)
end

When(/^I install MongoDB$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=.vagrant/machines/meanserver/virtualbox/private_key -u vagrant playbook.mean.yml --tags 'mongodb_setup'"

    output, error, @status = Open3.capture3 "#{cmd}"
end

Then(/^it should be successful$/) do
  expect(@status.success?).to eq(true)
end

Then(/^MongoDB should be running$/) do
  output, error, status = Open3.capture3 "unset RUBYLIB; vagrant ssh -c 'sudo service mongod status'"

  expect(status.success?).to eq(true)
  expect(output).to match("mongod start/running")
end
