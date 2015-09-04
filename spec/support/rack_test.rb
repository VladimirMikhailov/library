module Library
  module RackTest
    def app
      described_class
    end
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Library::RackTest
end
