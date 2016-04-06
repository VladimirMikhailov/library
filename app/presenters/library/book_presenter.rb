module Library
  class BookPresenter
    attr_reader :book
    private :book

    delegate :name, :published_at, :errors, to: :book

    def initialize(book)
      @book = book
    end

    def name_label
      error_or_label(:name, "Name")
    end

    def published_at_label
      error_or_label(:published_at, "Published at")
    end

    def valid_class(attribute)
      errors[attribute].first ? "invalid" : ""
    end

    private

    def error_or_label(field, label)
      errors[field].first || label
    end
  end
end
