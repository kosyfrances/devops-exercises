require 'open3'

When(/^I install Vault and Consul$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.secure_vault.yml --tags 'install_vault_and_consul'"

  _, _, @status = Open3.capture3 "#{cmd}"
end
