require "sinatra/activerecord/rake"
require_relative "config/environment"
require_relative "lib/library"

Dir[File.expand_path("../lib/tasks/**/*.rake", __FILE__)].each { |f| load f }

task default: :spec
