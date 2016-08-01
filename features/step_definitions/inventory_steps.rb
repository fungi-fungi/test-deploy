Given(/^I have (\d+) items in my inventory$/) do |arg1|
  account = FactoryGirl.create(:account, sfid: '0013600000NSyCRAA1')
  FactoryGirl.create_list(:stock_item, arg1.to_i, account: account)
end

Given(/^I am on my profile page$/) do
  step "I am on main page"
  step "I enter correct credentials"
  expect(page).to have_content("It works 3")
end

When(/^I go to "([^"]*)" page$/) do |arg1|
  find("a#inventory-page").click
  expect(page).to have_content("This is the inventory view.")
end

When(/^I request my inventory$/) do
  find("button#get-inventory").click
  expect(page).to have_content("clicked")
end

Then(/^I can see (\d+) items in my inventory$/) do |arg1|
  expect(page).to have_content(StockItem.first.name)
  expect(find('#inventory-table').all('tr').size).to eq(arg1.to_i)
end