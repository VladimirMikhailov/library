APP_FILE = "config/environment"
APP_CLASS = "Library::GraphsController"

require "sinatra/activerecord/rake"
require "sinatra/assetpack/rake"
require "jasmine"
load "jasmine/tasks/jasmine.rake"
require_relative(APP_FILE)
require_relative "lib/library"

Dir[File.expand_path("../lib/tasks/**/*.rake", __FILE__)].each { |f| load f }

task default: :spec
