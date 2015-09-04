FactoryGirl.definition_file_paths = %w(./spec/factories)
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
