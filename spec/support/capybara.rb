RSpec.configure do |config|
  config.include Capybara::DSL, feature: true
end

Capybara.app = Rack::Builder.parse_file(
  File.expand_path("../../../config.ru", __FILE__)
).first

Capybara.configure do |config|
  config.match = :prefer_exact
  config.javascript_driver = :poltergeist
end
