module Library
  class PaginatableQuery
    class AscPreloaded < BasePreloaded
      def all
        klass.with(
          previous: previous,
          paginated: collection.limit(per_page + 1)
        ).from(union)
      end

      private

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
