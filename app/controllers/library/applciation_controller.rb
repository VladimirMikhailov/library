module Library
  class ApplicationController < Sinatra::Base
    set :views, proc { File.join(root, "../../views") }
    set :method_override, true
  end
end
