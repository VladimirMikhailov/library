module Library
  class PaginatableQuery
    class DESCPaginated < BasePaginated
      delegate :last, to: :all
      delegate :id, to: :last, prefix: true, allow_nil: true

      def all
        klass.with(
          paginated: paginated,
          next_records: next_records
        ).from(union).order("id")
      end

      def next?
        last_id && last_id.to_i > last_seen_id
      end

      def previous?
        all.length > per_page + indent
      end

      private

      def indent
        next? ? 1 : 0
      end

      def paginated
        collection
          .where("#{table_name}.id <= ?", last_seen_id)
          .order("id DESC").limit(per_page + 1)
      end

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
