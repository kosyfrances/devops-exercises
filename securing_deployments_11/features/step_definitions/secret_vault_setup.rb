require 'open3'

When(/^I install Vault$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.secure_vault.yml --tags 'install_vault'"

  _, _, @status = Open3.capture3 "#{cmd}"
end
