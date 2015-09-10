module Library
  module TopAuthorsPublishmentsGraph
    KEY = "top_authors"

    module_function def fetch
      store.fetch(KEY) do
        top_authors_publishments
      end
    end

    module_function def update!
      store.write(KEY) { top_authors_publishments }
    end

    private

    module_function def top_authors_publishments
      TopAuthorsPublishments.new.all
    end

    module_function def store
      ActiveSupport::Cache.lookup_store(:redis_store)
    end
  end
end
