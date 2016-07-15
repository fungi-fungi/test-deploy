When(/^I am on the homepage$/) do
  visit 'http://localhost:9000'
  save_screenshot('./file.png', :full => true)
end

Then(/^I should see hello world text$/) do
  click_button('Get welcomed')
  save_screenshot('./file1.png', :full => true)
  expect(find('.marketing').find('h1')).to have_content('Hello world')
end