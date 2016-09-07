Given(/^I have account$/) do
  FactoryGirl.create(:account, sfid: '0013600000NSyCRAA1')
end

Given(/^I have (\d+) items in my inventory$/) do |arg1|
  FactoryGirl.create_list(:stock_item_belongs_to_iurii, arg1.to_i)
end

Given(/^I am on my profile page$/) do
  step "I am on main page"
  step "I enter correct credentials"
  expect(page).to have_content("It works 3")
end

When(/^I go to Inventory page$/) do
  find("a#inventory-page").click
  expect(page).to have_content("This is the inventory view.")
end

Then(/^I can see (\d+) items in my inventory$/) do |arg1|
  expect(page).to have_content(StockItem.first.item.name)
  expect(find('#inventory-table').all('tr').size).to eq(arg1.to_i)
end