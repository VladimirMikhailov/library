require_relative "config/environment"
require "sinatra/activerecord/rake"
require_relative "lib/library"

Dir[File.expand_path("../lib/tasks/**/*.rake", __FILE__)].each { |f| load f }

task default: :spec
