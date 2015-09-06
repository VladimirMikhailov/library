module Library
  class PaginatableQuery
    class DescPreloaded < BasePreloaded
      def all
        klass.with(
          paginated: collection.limit(per_page + 1),
          next_records: next_records
        ).from(union).order("id")
      end

      private

      def next_records
        klass.where("id > ?", last_seen_id).order("id").limit(1)
      end

      def union
        <<-SQL
          (
            SELECT * FROM paginated
            UNION ALL
            SELECT * FROM next_records
          ) books
        SQL
      end
    end
  end
end
