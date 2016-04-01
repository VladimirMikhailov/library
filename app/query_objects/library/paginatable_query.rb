module Library
  class PaginatableQuery
    include Enumerable

    PER_PAGE = 30

    attr_reader :collection, :params
    private :collection, :params

    delegate :each, to: :all

    delegate :table_name, to: :collection
    private :table_name

    def initialize(collection, params)
      @collection = collection
      @params = params
    end

    def all
      @all ||= paginated.order("id").limit(PER_PAGE)
    end

    def last_id
      all.last && all.last.id
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
