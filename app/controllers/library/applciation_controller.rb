module Library
  class ApplicationController < Sinatra::Base
    set :views, proc { File.join(root, "../../views") }
  end
end
