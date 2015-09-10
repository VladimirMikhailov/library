module Library
  module BooksHelpers
    module_function def books_path(book = nil, **params)
      Path.new(book, params).to_s
    end

    def published_at_min
      Book::PUBLISHMENTS.min
    end

    def published_at_max
      Book::PUBLISHMENTS.max
    end

    def rand_author_ids
      Author.where("id < ?", rand(4..5_000_000))
        .limit(rand(1..3))
        .pluck(:id)
        .join(",")
    end

    class Path
      ROOT = "/books"

      attr_reader :book, :params
      private :book, :params

      def initialize(book, params)
        @book = book
        @params = params || {}
      end

      def to_s
        [
          single_or_plural,
          normalized_params.presence
        ].compact.join("?")
      end

      private

      def single_or_plural
        book ? [ROOT, book.id].join("/") : ROOT
      end

      def normalized_params
        params.reject { |_, value| value.blank? }
          .map { |key, value| "#{key}=#{value}" }
          .join("&")
      end
    end
  end
end
