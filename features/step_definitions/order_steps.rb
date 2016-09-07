Given(/^I have (\d+) avaliable configuration$/) do |arg1|
  FactoryGirl.create_list(:configuration_belongs_to_iurii, arg1.to_i)
end

When(/^I go to Configuration page$/) do
  find("a#configurations-page").click
  expect(page).to have_content("This is the NewOrder view.")
end

Then(/^I can see (\d+) avaliable configurations$/) do |arg1|
  expect(page).to have_content(Configuration.first.name)
  expect(find('#configurations-table').all('tr').size).to eq(arg1.to_i)
end

Given(/^I have (\d+) previous orders$/) do |arg1|
  FactoryGirl.create_list(:order_request_with_sets_iurii, arg1.to_i)
end

When(/^I go to Orders page$/) do
  find("a#orders-page").click
  expect(page).to have_content("This is the Orders view.")
end

Then(/^I can see (\d+) orders$/) do |arg1|
  expect(page).to have_content(OrderRequest.first.sfid)
  expect(find('#orders-table').all('tr').size).to eq(arg1.to_i)
end

When(/^click on detail for random category$/) do
  expect(page).to have_content(Configuration.first.name)
  rows = find('#configurations-table').all('tr')
  page.all('a', text: 'Details')[rand(rows.count)].click
end

Then(/^I can see all elements required for configuration$/) do
  expect(page).to have_content("Required Items")
  expect(page).to have_content("Required Categories")
  
  configuration = Configuration.find(current_url.split('/').last.to_i) 
    
  expect(find('#required-items-table').all('tr').size).to eq(configuration.category_set.category_entities.size)
  expect(find('#required-categories-table').all('tr').size).to eq(configuration.bom.item_entities.size)
end