Given(/^I have (\d+) items in my inventory$/) do |arg1|
  account = FactoryGirl.create(:account, sfid: '0013600000NSyCRAA1')
  FactoryGirl.create_list(:stock_item, arg1.to_i, account: account)
end

Given(/^I am on my profile page$/) do
  step "I am on main page"
  step "I enter correct credentials"
end

When(/^I go to "([^"]*)" page$/) do |arg1|
  find('.navbar').click_link(arg1)
end

When(/^I request my inventory$/) do
  click_button("Get stock")
end

Then(/^I can see (\d+) items in my inventory$/) do |arg1|
  expect(page).to have_selector('table')
end