ENV["SINATRA_ENV"] ||= "development"

require "bundler/setup"
Bundler.require(:default, ENV["SINATRA_ENV"])

Dir[File.expand_path("../initializers/**/*.rb", __FILE__)].each { |f| require f }

require_relative "../lib/library"
require_all "app"
