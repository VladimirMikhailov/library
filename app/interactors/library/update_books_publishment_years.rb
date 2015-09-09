module Library
  class UpdateBooksPublishmentYears
    include Interactor

    DECREMENT = "decrement"
    CHANGE_BY = 1

    delegate :published_at, to: "context.book", prefix: "book"

    def call
      BooksPublishmentYear
        .where(id: book_published_at)
        .update_all("count = GREATEST(count #{increment_or_decrement_sign} #{CHANGE_BY}, 0)")
    end

    private

    def increment_or_decrement_sign
      context.action == DECREMENT ? "-" : "+"
    end
  end
end
