require 'open3'

Given(/^I have a running server$/) do
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant reload"

  expect(status.success?).to eq(true)
end

Given(/^I provision it$/) do
  _, _, status = Open3.capture3 "unset RUBYLIB; vagrant provision"

  expect(status.success?).to eq(true)
end

When(/^I install automysqlbackup$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.backup.yml --tags 'install_automysqlbackup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

Then(/^it should be successful$/) do
  expect(@status.success?).to eq(true)
end

When(/^I run backup command$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.backup.yml --tags 'backup_cmd'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

And(/^backup folders should exist$/) do
  output, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh -c 'ls /var/lib/automysqlbackup/'"

  output.split.each do |folder|
    _, _, status = Open3.capture3 "unset RUBYLIB; vagrant ssh -c 'test -d /var/lib/automysqlbackup/#{folder}'"

    expect(status.success?).to eq(true)
  end

  expect(status.success?).to eq(true)
end

When(/^I create test database$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.verify_backup.yml --tags 'test_db'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I load latest database backup to test database$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.verify_backup.yml --tags 'import_backup'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I compare database backup to match$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.verify_backup.yml --tags 'compare_backup' -vvv"

  _, _, @status = Open3.capture3 "#{cmd}"
end
