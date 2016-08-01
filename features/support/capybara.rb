require 'capybara/poltergeist'

# Capybara.register_driver :poltergeist do |app|
#   Capybara::Poltergeist::Driver.new(app, :phantomjs => Phantomjs.path, js_errors: true)
# end

include Capybara::Angular::DSL

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :browser => :phantomjs)
end

Capybara.javascript_driver = :poltergeist

Capybara.configure do |config|
  config.default_max_wait_time = 15
  config.server_port = 3000
end

Capybara.default_driver = :poltergeist
# Capybara.javascript_driver = :poltergeist
