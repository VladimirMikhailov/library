module Library
  module RedisStore
    def redis_store
      ActiveSupport::Cache.lookup_store(:redis_store)
    end
  end
end

RSpec.configure do |config|
  config.include Library::RedisStore
end
