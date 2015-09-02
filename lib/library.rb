require "sinatra/activerecord"

class Library < Sinatra::Base
  register Sinatra::ActiveRecordExtension
end
