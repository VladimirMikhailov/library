source "https://rubygems.org/"
ruby "2.2.2"

gem "sinatra"
gem "sinatra-contrib"
gem "sinatra-activerecord"
gem "sinatra-assetpack"
gem "slim"
gem "pg"
gem "require_all"
gem "ffaker"
gem "postgres_ext"
gem "interactor"
gem "que"
gem "redis"
gem "redis-activesupport"
gem "active_model_serializers"

group :development do
  gem "rake"
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false
  gem "ruby-progressbar"
  gem "foreman", require: false
end

group :development, :test do
  gem "capybara"
  gem "factory_girl"
  gem "rack-test"
  gem "rspec"
  gem "database_rewinder"
  gem "codeclimate-test-reporter", require: false
  gem "jasmine"
end
