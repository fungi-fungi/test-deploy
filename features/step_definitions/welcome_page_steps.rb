When(/^I am on the homepage$/) do
  step "I am on main page"
  step "I enter correct credentials"
end

When(/^I submit new request$/) do
  click_button('Get welcomed')
end

Then(/^I should see hello world text$/) do
  expect(find('.marketing').find('h2')).to have_content('Hello world')
end