require_relative "config/environment"
require "sinatra/activerecord/rake"
require_relative "lib/library"

task default: :spec

Rake::TestTask.new(:spec) do |t|
  t.test_files = FileList["spec/*_spec.rb"]
end
