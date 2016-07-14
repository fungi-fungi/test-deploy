When(/^I am on the homepage$/) do
  visit '/api/v1/welcome'
end

Then(/^I should see hello world text$/) do
  expect(page).to have_content "Hello world"
end