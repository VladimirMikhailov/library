module Library
  class PaginatableQuery
    include Enumerable

    PER_PAGE = 30
    DIRECTIONS = %w(ASC DESC)

    attr_reader :collection, :direction, :per_page, :last_seen_id
    private :collection, :direction, :per_page, :last_seen_id

    delegate :next?, :previous?, to: :paginated
    delegate :each, :last, to: :all
    delegate :id, to: :last, prefix: true
    delegate :first, to: :paginated, prefix: true
    delegate :id, to: :paginated_first, prefix: true

    def initialize(
      collection,
      per_page: PER_PAGE,
      last_seen_id: 0,
      direction: "ASC"
    )
      @collection = collection
      @per_page = per_page || PER_PAGE
      @last_seen_id = last_seen_id || 0
      @direction = DIRECTIONS.include?(direction.upcase) ? direction.upcase : DIRECTIONS.first
    end

    def all
      result = paginated.all.to_a.dup

      previous? && result.shift
      next? && result.pop

      result
    end

    private

    def paginated
      @paginated ||= direction_preloaded.new(
        collection,
        per_page: per_page,
        last_seen_id: last_seen_id
      )
    end

    def direction_preloaded
      PaginatableQuery.const_get("#{direction}Paginated")
    end
  end
end
