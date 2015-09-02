require "find"

%w(config/initializers lib).each do |load_path|
  Find.find(load_path) do |f|
    require f unless f.match(/\/\..+$/) || File.directory?(f)
  end
end

class Library
end
