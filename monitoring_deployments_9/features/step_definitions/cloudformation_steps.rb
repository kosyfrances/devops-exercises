require 'open3'
require 'json'

When(/^I launch cloudformation stack$/) do
  cmd = "ansible-playbook playbook.ec2.yml"

  _, _, @status = Open3.capture3 "#{cmd}"
end

Then(/^two instances should be created$/) do
  cmd = "aws cloudformation list-stack-resources --stack-name EC2 --region us-west-2"
  output, _, _ = Open3.capture3 "#{cmd}"
  output = JSON.parse(output)
  summary = output["StackResourceSummaries"]
  expect(summary.size).to eq(2)
  expect(summary.first['ResourceType']).to match("AWS::EC2::Instance")
  expect(summary.last['ResourceType']).to match("AWS::EC2::Instance")
end
