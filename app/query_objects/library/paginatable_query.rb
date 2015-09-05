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
      direction: "ASC"
    )
      @collection = collection
      @per_page = per_page || PER_PAGE
      @last_seen_id = last_seen_id || 0
      @direction = DIRECTIONS.key?(direction.upcase) ? direction.upcase : DIRECTIONS.keys.first
    end

    def all
      collection.klass.from(
        collection.order("#{table_name}.id #{direction}")
          .where("#{table_name}.id #{direction_condition} ?", last_seen_id)
          .limit(per_page),
        table_name
      ).order("#{table_name}.id")
    end

    private

    def direction_condition
      DIRECTIONS[direction]
    end

    def table_name
      collection.klass.table_name
    end
  end
end
