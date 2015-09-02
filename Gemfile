source "https://rubygems.org/"

gem "sinatra"
gem "sinatra-activerecord"
gem "pg"
gem "require_all"
gem "ffaker"

group :development do
  gem "rake"
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false
end

group :development, :test do
  gem "rspec"
  gem "database_rewinder"
end
