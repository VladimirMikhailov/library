module Library
  class PaginatableQuery
    PER_PAGE = 30
    DIRECTIONS = { "ASC" => ">", "DESC" => "<=" }

    attr_reader :collection, :direction, :per_page, :last_seen_id
    private :collection, :direction, :per_page, :last_seen_id

    def initialize(
      collection,
      per_page: PER_PAGE,
      last_seen_id: 0,
      direction: DIRECTION
    )
      @collection = collection
      @per_page = per_page || PER_PAGE
      @last_seen_id = last_seen_id || 0
      @direction = DIRECTIONS.fetch(direction.upcase, DIRECTIONS["ASC"])
    end

    def all
      collection.order("#{table_name}.id")
        .where("#{table_name}.id #{direction} ?", last_seen_id)
        .limit(per_page)
    end

    private

    def table_name
      collection.klass.table_name
    end
  end
end
