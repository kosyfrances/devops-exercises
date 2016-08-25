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

When(/^I create a test repo$/) do
  _, _, status = Open3.capture3 "vagrant ssh -c 'mkdir testrepo && touch testrepo/testfile.txt && git init testrepo'"

  expect(status.success?).to eq(true)
end

And(/^run script against test repo$/) do
  _, _, status = Open3.capture3 "vagrant ssh -c './run_git_secret_hook.sh testrepo/'"

  expect(status.success?).to eq(true)
end

And(/^I add aws secret to the repo$/) do
  _, _, status = Open3.capture3 "vagrant ssh -c 'echo AWS Secret Access Key: random_Secret >> testrepo/testfile.txt'"

  expect(status.success?).to eq(true)
end

Then(/^aws secret should not be committed$/) do
  _, _, status = Open3.capture3 "vagrant ssh -c 'cd testrepo && git add . && git commit -m \"Test commit\"'"

  expect(status.success?).to eq(false)
end

And(/^test repo should be deleted$/) do
  _, _, status = Open3.capture3 "vagrant ssh -c 'rm -rf testrepo/'"

  expect(status.success?).to eq(true)
end
