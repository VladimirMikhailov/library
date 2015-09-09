module Library
  class UpdateBooksPublishmentYears
    include Interactor
    include IncrementableDecrementable

    delegate :published_at, to: "context.book", prefix: "book"

    def call
      BooksPublishmentYear
        .where(id: book_published_at)
        .update_all("count = GREATEST(count #{increment_or_decrement_sign} #{CHANGE_BY}, 0)")
    end
  end
end
