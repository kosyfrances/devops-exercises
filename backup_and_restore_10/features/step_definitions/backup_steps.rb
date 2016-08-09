require 'open3'

Given(/^I have a running server$/) do
  _, _, status = Open3.capture3 "vagrant reload"

  expect(status.success?).to eq(true)
end

Given(/^I provision it$/) do
  _, _, status = Open3.capture3 "vagrant provision"

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
  output, _, status = Open3.capture3 "vagrant ssh -c 'ls /var/lib/automysqlbackup/'"

  output.split.each do |folder|
    _, _, status = Open3.capture3 "vagrant ssh -c 'test -d /var/lib/automysqlbackup/#{folder}'"

    expect(status.success?).to eq(true)
  end

  expect(status.success?).to eq(true)
end

When(/^I copy backup script to server$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.backup.yml --tags 'copy_backup_script'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

Then(/^backup script should exist in server$/) do
  _, _, status = Open3.capture3 "vagrant ssh -c 'test -f /etc/automysqlbackup/backup.sh'"
end

When(/^I execute cron task$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.backup.yml --tags 'run_cron'"

  _, _, @status = Open3.capture3 "#{cmd}"
end
