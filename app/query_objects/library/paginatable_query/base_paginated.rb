module Library
  class PaginatableQuery
    class BasePaginated
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

      private

      def table_name
        collection.klass.table_name
      end
    end
  end
end
