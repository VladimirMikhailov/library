module Library
  class PaginatableQuery
    class AscPreloaded
      attr_reader :collection, :per_page, :last_seen_id
      private :collection, :per_page, :last_seen_id

      delegate :klass, to: :collection
      delegate :first, to: :all
      delegate :id, to: :first, prefix: true, allow_nil: true

      def initialize(collection, per_page:, last_seen_id:)
        @collection = collection
        @per_page = per_page.to_i
        @last_seen_id = last_seen_id.to_i
      end

      def all
        klass.with(
          previous: previous,
          paginated: collection.limit(per_page + 1)
        ).from(union)
      end

      def next?
        all.length > per_page + indent
      end

      def previous?
        first_id.to_i < last_seen_id
      end

      private

      def indent
        previous? ? 1 : 0
      end

      def previous
        klass.where("id <= ?", last_seen_id).order("id DESC").limit(1)
      end

      def union
        <<-SQL
          (
            SELECT * FROM previous
            UNION ALL
            SELECT * FROM paginated
          ) books
        SQL
      end
    end
  end
end
