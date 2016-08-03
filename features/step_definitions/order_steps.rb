Given(/^I have (\d+) avaliable configuration$/) do |arg1|
  FactoryGirl.create_list(:configuration, arg1.to_i, account: Account.where(sfid: '0013600000NSyCRAA1').first)
end

When(/^I go to Configuration page$/) do
  find("a#configurations-page").click
  expect(page).to have_content("This is the NewOrder view.")
end

Then(/^I can see (\d+) avaliable configurations$/) do |arg1|
  expect(page).to have_content(Configuration.first.name)
  expect(find('#configurations-table').all('tr').size).to eq(arg1.to_i)
end