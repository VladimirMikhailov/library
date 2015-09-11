module Library
  class ApplicationController < Sinatra::Base
    register Sinatra::AssetPack

    set :root, File.expand_path("../../", __dir__)
    set :views, proc { File.join(root, "views") }
    set :method_override, true
  end
end
