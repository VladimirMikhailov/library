module Library
  class PaginatableQuery
    class BasePreloaded
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
    end
  end
end
