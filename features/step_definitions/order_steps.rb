Given(/^I have account$/) do
  FactoryGirl.create(:account, sfid: '0013600000NSyCRAA1')
end

Given(/^I have (\d+) avaliable configuration$/) do |arg1|
  FactoryGirl.create_list(:configuration, arg1, sfid: '0013600000NSyCRAA1')
end

Then(/^I can see (\d+) avaliable configurations$/) do |arg1|
  
end