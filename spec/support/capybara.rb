RSpec.configure do |config|
  config.include Capybara::DSL, feature: true
end

Capybara.configure do |config|
  config.match = :prefer_exact
  config.javascript_driver = :poltergeist
end
