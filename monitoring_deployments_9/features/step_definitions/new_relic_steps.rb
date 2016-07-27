require 'open3'

When(/^I install newrelic$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.newrelic.yml --tags 'newrelic_install'"

  output, _, @status = Open3.capture3 "#{cmd}"
end

When(/^I edit newrelic file$/) do
  cmd = "ansible-playbook -i local_inventory.ini playbook.newrelic.yml --tags 'newrelic_file'"

  output, _, @status = Open3.capture3 "#{cmd}"
end
