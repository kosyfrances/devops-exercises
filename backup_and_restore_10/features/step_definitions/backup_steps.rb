require 'open3'

Given(/^I have a running server$/) do
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant reload"

  expect(status.success?).to eq(true)
end

When(/^I install automysqlbackup$/) do
  cmd = "ansible-playbook -i inventory.ini playbook.backup.yml --tags 'install_automysqlbackup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

Then(/^it should be successful$/) do
  expect(@status.success?).to eq(true)
end

When(/^I run backup command$/) do
  cmd = "ansible-playbook -i inventory.ini playbook.backup.yml --tags 'backup_cmd'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

Then(/^backup folders should exist$/) do
  output, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh -c 'ls /var/lib/automysqlbackup/'"

  output.split.each do |folder|
    _, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh -c 'test -d /var/lib/automysqlbackup/#{folder}'"

    expect(status.success?).to eq(true)
  end

  expect(status.success?).to eq(true)
end
