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
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^it should be successful$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
