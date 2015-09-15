if ENV["CODECLIMATE_REPO_TOKEN"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

ENV["SINATRA_ENV"] = "test"

require_relative "../config/environment"

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |f| require f }
ActiveRecord::Base.logger = nil

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
