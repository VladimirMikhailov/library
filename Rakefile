%w(bundler find rake/testtask).each { |lib| require lib }
require "sinatra/activerecord/rake"
require_relative "lib/library"

task default: :spec

Rake::TestTask.new(:spec) do |t|
  t.test_files = FileList["spec/*_spec.rb"]
end
