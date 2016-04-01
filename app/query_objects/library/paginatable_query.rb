module Library
  class PaginatableQuery
    include Enumerable

    PER_PAGE = 30

    attr_reader :collection, :params
    private :collection, :params

    delegate :table_name, to: :collection
    private :table_name

    def initialize(collection, params)
      @collection = collection
      @params = params
    end

    def all
      paginated
        .order("id")
        .limit(PER_PAGE)
    end

    private

    def paginated
      return collection unless last_seen_id
      collection.where("#{table_name}.id > ?", last_seen_id)
    end

    def last_seen_id
      params["last_seen_id"]
    end
  end
end
