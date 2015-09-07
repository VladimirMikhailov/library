module Library
  class PaginatableQuery
    class ASCPaginated < BasePaginated
      def all
        @all ||= klass.with(
          previous: previous,
          paginated: paginated
        ).from(union)
      end

      def next?
        all.length > per_page + indent
      end

      def previous?
        first_id && first_id <= last_seen_id
      end

      private

      def indent
        previous? ? 1 : 0
      end

      def paginated
        collection
          .where("#{table_name}.id > ?", last_seen_id)
          .order("id").limit(per_page + 1)
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
