Given(/^I am on main page$/) do
  visit 'http://localhost:9000/#!/logout'
  visit 'http://localhost:9000'
end

When(/^I enter correct credentials$/) do
  fill_in 'email', :with => 'iurii@gwexhibits.com'
  fill_in 'password', :with => '03051990'
  find('.a0-next').click
end

Then(/^I can see my profile$/) do
  expect(find('.marketing').find('h1')).to have_content('It works 3')
end

Given(/^I am logged in$/) do
  step "I am on main page"
  step "I enter correct credentials"
end

When(/^I logout$/) do
  visit 'http://localhost:9000/#!/logout'
end

Then(/^I am logged out$/) do
   expect(find('h1')).to have_content('Log in')
end