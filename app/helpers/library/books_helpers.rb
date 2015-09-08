module Library
  module BooksHelpers
    def books_path(book = nil, **params)
      Path.new(book, params).to_s
    end
    module_function :books_path

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
