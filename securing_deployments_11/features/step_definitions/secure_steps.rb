require 'open3'

Given(/^I have a running server$/) do
  _, _, status = Open3.capture3 "vagrant reload"

  expect(status.success?).to eq(true)
end

Given(/^I provision it$/) do
  _, _, status = Open3.capture3 "vagrant provision"

  expect(status.success?).to eq(true)
end

When(/^I install git\-secrets$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.secure_credential_hook.yml --tags 'install_git_secret'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

Then(/^it should be successful$/) do
  expect(@status.success?).to eq(true)
end

Then(/^git\-secrets command should be available$/) do
  output, _, status = Open3.capture3 "vagrant ssh -c 'type git-secrets'"

  expect(status.success?).to eq(true)
  expect(output).to match("git-secrets is /usr/local/bin/git-secrets")
end

When(/^I copy script to setup hook on server$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.secure_credential_hook.yml --tags 'copy_hook_script'"

  _, _, @status = Open3.capture3 "#{cmd}"
end

Then(/^script should exist$/) do
  _, _, status = Open3.capture3 "vagrant ssh -c 'test -f run_git_secret_hook.sh'"

  expect(status.success?).to eq(true)
end
